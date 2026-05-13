#!/usr/bin/env bash
set -euo pipefail

input_dir="generated/klassenarbeiten"
output_guide="${input_dir}/WORKBENCH-MWB-WORKFLOW.md"
only_system=""
db_prefix="wb_"
db_charset="utf8"
db_collation="utf8_general_ci"
align_fk_index_patterns="1"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --input-dir)
      input_dir="$2"
      shift 2
      ;;
    --output-guide)
      output_guide="$2"
      shift 2
      ;;
    --only-system)
      only_system="$2"
      shift 2
      ;;
    --db-prefix)
      db_prefix="$2"
      shift 2
      ;;
    --db-charset)
      db_charset="$2"
      shift 2
      ;;
    --db-collation)
      db_collation="$2"
      shift 2
      ;;
    --skip-fk-index-alignment)
      align_fk_index_patterns="0"
      shift 1
      ;;
    -h|--help)
      cat <<'EOF'
Verwendung:
  bash scripts/prepare-workbench-mwb.sh [Optionen]

Optionen:
  --input-dir <pfad>      Verzeichnis mit *_struktur_*.sql (Default: generated/klassenarbeiten)
  --output-guide <pfad>   Zieldatei fuer den Workbench-Workflow (Default: generated/klassenarbeiten/WORKBENCH-MWB-WORKFLOW.md)
  --only-system <name>    Nur ein System verarbeiten (z. B. stadtfahrradverleih)
  --db-prefix <prefix>    Prefix fuer erzeugte Datenbanken (Default: wb_)
  --db-charset <wert>     Zeichenkodierung fuer umgeschriebene DBs (Default: utf8)
  --db-collation <wert>   Kollation fuer umgeschriebene DBs (Default: utf8_general_ci)
  --skip-fk-index-alignment
                           FK-/Index-Benennung nicht normalisieren
  -h, --help              Hilfe anzeigen

Ergebnis:
  1) SQL-Struktur + SQL-Daten werden in getrennte DB-Schemas geladen.
  2) Eine Anleitung fuer MySQL Workbench wird erzeugt, um daraus echte .mwb zu speichern.
EOF
      exit 0
      ;;
    *)
      echo "[prepare-mwb] Unbekannte Option: $1"
      exit 1
      ;;
  esac
done

if [[ ! -d "$input_dir" ]]; then
  echo "[prepare-mwb] Fehler: Eingabeverzeichnis nicht gefunden: $input_dir"
  exit 1
fi

runtime_root_pw="${MYSQL_ROOT_PASSWORD:-}"

if [[ -f .env ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env
  set +a
fi

if [[ -n "$runtime_root_pw" ]]; then
  MYSQL_ROOT_PASSWORD="$runtime_root_pw"
fi

if [[ -z "${MYSQL_ROOT_PASSWORD:-}" || "${MYSQL_ROOT_PASSWORD}" == CHANGE_ME* ]]; then
  echo "[prepare-mwb] Fehler: MYSQL_ROOT_PASSWORD fehlt oder ist ungueltig."
  echo "[prepare-mwb] Bitte .env konfigurieren oder MYSQL_ROOT_PASSWORD als Umgebungsvariable setzen."
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "[prepare-mwb] Fehler: docker nicht gefunden."
  exit 1
fi

if ! docker compose ps --status running --services 2>/dev/null | grep -qx "mysql"; then
  echo "[prepare-mwb] Fehler: MySQL-Container laeuft nicht."
  echo "[prepare-mwb] Tipp: bash scripts/start-services.sh"
  exit 1
fi

sanitize_identifier() {
  local value="$1"
  value="${value,,}"
  value="$(echo "$value" | tr -cs 'a-z0-9_' '_')"
  value="${value#_}"
  value="${value%_}"
  echo "$value"
}

escape_mysql_identifier() {
  local value="$1"
  printf '%s' "$value" | sed 's/`/``/g'
}

normalize_fk_base_name() {
  local child_table="$1"
  local parent_table="$2"
  local base

  base="fk_$(sanitize_identifier "${child_table}")_$(sanitize_identifier "${parent_table}")"
  if [[ -z "$base" || "$base" == "fk__" ]]; then
    base="fk_relation"
  fi
  printf '%s\n' "$base"
}

build_fk_name() {
  local base="$1"
  local ordinal="$2"
  local max_len=64
  local suffix=""
  local name
  local allowed_base_len

  if [[ "$ordinal" -gt 1 ]]; then
    suffix="_${ordinal}"
  fi

  allowed_base_len=$((max_len - ${#suffix}))
  if [[ ${#base} -gt $allowed_base_len ]]; then
    base="${base:0:$allowed_base_len}"
  fi

  name="${base}${suffix}"
  printf '%s\n' "$name"
}

ensure_index_for_fk_columns() {
  local db_name="$1"
  local table_name="$2"
  local target_index_name="$3"
  local fk_columns_sql="$4"
  local existing_index_name=""
  local index_rows=""
  local idx_name=""
  local idx_columns=""
  local table_escaped
  local target_idx_escaped

  index_rows="$(docker compose exec -T mysql mysql -N -B -uroot -p"${MYSQL_ROOT_PASSWORD}" -e '
SELECT INDEX_NAME,
       GROUP_CONCAT(CONCAT(CHAR(96), COLUMN_NAME, CHAR(96)) ORDER BY SEQ_IN_INDEX SEPARATOR ",") AS index_columns
  FROM information_schema.STATISTICS
 WHERE TABLE_SCHEMA="'"${db_name}"'"
   AND TABLE_NAME="'"${table_name}"'"
   AND INDEX_NAME <> "PRIMARY"
 GROUP BY INDEX_NAME
 ORDER BY INDEX_NAME;')"

  while IFS=$'\t' read -r idx_name idx_columns; do
    [[ -n "$idx_name" ]] || continue
    if [[ "$idx_columns" == "$fk_columns_sql" ]]; then
      existing_index_name="$idx_name"
      break
    fi
  done <<< "$index_rows"

  table_escaped="$(escape_mysql_identifier "$table_name")"
  target_idx_escaped="$(escape_mysql_identifier "$target_index_name")"

  if [[ -n "$existing_index_name" ]]; then
    if [[ "$existing_index_name" != "$target_index_name" ]]; then
      local existing_escaped
      existing_escaped="$(escape_mysql_identifier "$existing_index_name")"
      docker compose exec -T mysql mysql -N -B -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "
ALTER TABLE \`${db_name}\`.\`${table_escaped}\`
  RENAME INDEX \`${existing_escaped}\` TO \`${target_idx_escaped}\`;" 2>/dev/null
    fi
    return 0
  fi

  docker compose exec -T mysql mysql -N -B -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "
ALTER TABLE \`${db_name}\`.\`${table_escaped}\`
  ADD INDEX \`${target_idx_escaped}\` (${fk_columns_sql});"
}

align_fk_index_patterns_for_schema() {
  local db_name="$1"
  local fk_rows=""
  local fk_name=""
  local table_name=""
  local ref_table_name=""
  local update_rule=""
  local delete_rule=""
  local fk_columns_sql=""
  local ref_columns_sql=""
  local base_name=""
  local key=""
  local ordinal=0
  local target_fk_name=""
  local target_index_name=""
  local table_escaped
  local ref_table_escaped
  local old_fk_escaped
  local target_fk_escaped

  declare -A pair_counter=()

  fk_rows="$(docker compose exec -T mysql mysql -N -B -uroot -p"${MYSQL_ROOT_PASSWORD}" -e '
SELECT rc.CONSTRAINT_NAME,
       rc.TABLE_NAME,
       rc.REFERENCED_TABLE_NAME,
       rc.UPDATE_RULE,
       rc.DELETE_RULE,
       GROUP_CONCAT(CONCAT(CHAR(96), kcu.COLUMN_NAME, CHAR(96)) ORDER BY kcu.ORDINAL_POSITION SEPARATOR ",") AS fk_columns,
       GROUP_CONCAT(CONCAT(CHAR(96), kcu.REFERENCED_COLUMN_NAME, CHAR(96)) ORDER BY kcu.ORDINAL_POSITION SEPARATOR ",") AS ref_columns
  FROM information_schema.REFERENTIAL_CONSTRAINTS rc
  JOIN information_schema.KEY_COLUMN_USAGE kcu
    ON rc.CONSTRAINT_SCHEMA = kcu.CONSTRAINT_SCHEMA
   AND rc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
   AND rc.TABLE_NAME = kcu.TABLE_NAME
 WHERE rc.CONSTRAINT_SCHEMA="'"${db_name}"'"
 GROUP BY rc.CONSTRAINT_NAME,
          rc.TABLE_NAME,
          rc.REFERENCED_TABLE_NAME,
          rc.UPDATE_RULE,
          rc.DELETE_RULE
 ORDER BY rc.TABLE_NAME,
          rc.CONSTRAINT_NAME;')"

  while IFS=$'\t' read -r fk_name table_name ref_table_name update_rule delete_rule fk_columns_sql ref_columns_sql; do
    [[ -n "$fk_name" ]] || continue

    base_name="$(normalize_fk_base_name "$table_name" "$ref_table_name")"
    key="${table_name}|${ref_table_name}"
    ordinal="${pair_counter[$key]:-0}"
    ordinal=$((ordinal + 1))
    pair_counter[$key]="$ordinal"

    target_fk_name="$(build_fk_name "$base_name" "$ordinal")"
    target_index_name="${target_fk_name}_idx"

    if [[ ${#target_index_name} -gt 64 ]]; then
      target_index_name="${target_index_name:0:64}"
    fi

    ensure_index_for_fk_columns "$db_name" "$table_name" "$target_index_name" "$fk_columns_sql"

    if [[ "$fk_name" != "$target_fk_name" ]]; then
      table_escaped="$(escape_mysql_identifier "$table_name")"
      ref_table_escaped="$(escape_mysql_identifier "$ref_table_name")"
      old_fk_escaped="$(escape_mysql_identifier "$fk_name")"
      target_fk_escaped="$(escape_mysql_identifier "$target_fk_name")"
      docker compose exec -T mysql mysql -N -B -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "
ALTER TABLE \`${db_name}\`.\`${table_escaped}\`
  DROP FOREIGN KEY \`${old_fk_escaped}\`,
  ADD CONSTRAINT \`${target_fk_escaped}\`
  FOREIGN KEY (${fk_columns_sql})
  REFERENCES \`${db_name}\`.\`${ref_table_escaped}\` (${ref_columns_sql})
  ON DELETE ${delete_rule}
  ON UPDATE ${update_rule};"
    fi
  done <<< "$fk_rows"
}

extract_db_charset() {
  local source_file="$1"
  local detected=""

  detected="$(grep -Eio 'CHARACTER[[:space:]]+SET[[:space:]]+[A-Za-z0-9_]+' "$source_file" | head -1 | awk '{print $3}')"
  if [[ -z "$detected" ]]; then
    detected="$(grep -Eio 'DEFAULT[[:space:]]+CHARACTER[[:space:]]+SET[[:space:]]+[A-Za-z0-9_]+' "$source_file" | head -1 | awk '{print $4}')"
  fi

  if [[ -n "$detected" ]]; then

    printf '%s\n' "$detected"
  else
    printf '%s\n' "$db_charset"
  fi
}

extract_db_collation() {
  local source_file="$1"
  local detected=""

  detected="$(grep -Eio 'COLLATE[[:space:]]+[A-Za-z0-9_]+' "$source_file" | head -1 | awk '{print $2}')"

  if [[ -n "$detected" ]]; then
    printf '%s\n' "$detected"
  else
    printf '%s\n' "$db_collation"
  fi
}

rewrite_sql_for_database() {
  local source_file="$1"
  local target_db="$2"
  local target_file="$3"
  local source_charset="$4"
  local source_collation="$5"

  awk -v db="$target_db" -v charset="$source_charset" -v coll="$source_collation" '
  {
    if ($0 ~ /^[[:space:]]*DROP[[:space:]]+DATABASE[[:space:]]+IF[[:space:]]+EXISTS[[:space:]]+/) {
      print "DROP DATABASE IF EXISTS " db ";"
      next
    }
    if ($0 ~ /^[[:space:]]*DROP[[:space:]]+SCHEMA[[:space:]]+IF[[:space:]]+EXISTS[[:space:]]+/) {
      print "DROP DATABASE IF EXISTS " db ";"
      next
    }
    if ($0 ~ /^[[:space:]]*CREATE[[:space:]]+DATABASE[[:space:]]+/) {
      print "CREATE DATABASE " db " CHARACTER SET " charset " COLLATE " coll ";"
      next
    }
    if ($0 ~ /^[[:space:]]*CREATE[[:space:]]+SCHEMA[[:space:]]+/) {
      print "CREATE DATABASE " db " CHARACTER SET " charset " COLLATE " coll ";"
      next
    }
    if ($0 ~ /^[[:space:]]*USE[[:space:]]+/) {
      print "USE " db ";"
      next
    }
    print $0
  }
  ' "$source_file" > "$target_file"
}

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

host_for_workbench="${MYSQL_HOST:-127.0.0.1}"
if [[ "$host_for_workbench" == "mysql" ]]; then
  host_for_workbench="127.0.0.1"
fi
port_for_workbench="${MYSQL_PORT:-3306}"
user_for_workbench="root"


entries=""
processed=0
errors=0

for struct_sql in "$input_dir"/*_struktur_*.sql; do
  [[ -e "$struct_sql" ]] || continue

  filename="$(basename "$struct_sql")"
  system_name="${filename%_struktur_*}"
  year_part="${filename##*_struktur_}"
  year="${year_part%.sql}"

  if [[ -n "$only_system" ]] && [[ "$system_name" != "$only_system" ]]; then
    continue
  fi

  data_sql="$input_dir/${system_name}_daten_${year}.sql"
  if [[ ! -f "$data_sql" ]]; then
    echo "[prepare-mwb] WARN: Daten-Datei fehlt, uebersprungen: $data_sql"
    errors=$((errors + 1))
    continue
  fi

  target_mwb="$input_dir/${system_name}_${year}.mwb"
  target_db_raw="${db_prefix}${system_name}_${year}"
  target_db="$(sanitize_identifier "$target_db_raw")"
  target_charset="$(extract_db_charset "$struct_sql")"
  target_collation="$(extract_db_collation "$struct_sql")"

  rewritten_struct="$tmp_dir/${system_name}_${year}_struktur.sql"
  rewritten_data="$tmp_dir/${system_name}_${year}_daten.sql"

  rewrite_sql_for_database "$struct_sql" "$target_db" "$rewritten_struct" "$target_charset" "$target_collation"
  rewrite_sql_for_database "$data_sql" "$target_db" "$rewritten_data" "$target_charset" "$target_collation"

  echo "[prepare-mwb] Importiere: ${system_name} (${year}) -> DB ${target_db} [${target_charset}/${target_collation}]"
  docker compose exec -T mysql mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" < "$rewritten_struct"
  docker compose exec -T mysql mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" < "$rewritten_data"

  if [[ "$align_fk_index_patterns" == "1" ]]; then
    echo "[prepare-mwb] Normalisiere FK-/Index-Muster in ${target_db}"
    align_fk_index_patterns_for_schema "$target_db"
  fi

  table_count=$(docker compose exec -T mysql mysql -N -B -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${target_db}';" | tr -d '\r')
  if [[ -z "$table_count" ]]; then
    table_count="0"
  fi

  entries+="$(printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s |' "$system_name" "$year" "$target_db" "$target_charset" "$target_collation" "$table_count" "$struct_sql" "$data_sql" "$target_mwb")"
  entries+=$'\n'
  processed=$((processed + 1))
done

if [[ $processed -eq 0 ]]; then
  echo "[prepare-mwb] Fehler: Keine verarbeitbaren *_struktur_*.sql Dateien fuer Guide-Erstellung gefunden."
  exit 1
fi

cat > "$output_guide" <<EOF
# Workflow: Echte MySQL Workbench .mwb aus SQL erzeugen

Diese Datei wurde automatisch erzeugt mit:

\`bash scripts/prepare-workbench-mwb.sh\`

FK-/Index-Muster-Normalisierung: $( [[ "$align_fk_index_patterns" == "1" ]] && echo "aktiv" || echo "deaktiviert" )

## 1) Vorbereitete Datenbankschemata

| System | Jahr | Schema fuer Reverse Engineering | Charset | Collation | Tabellen | Struktur-SQL | Daten-SQL | Ziel-.mwb |
|---|---:|---|---|---|---:|---|---|---|
${entries}

## 2) Schritte in MySQL Workbench (pro System)

1. Workbench starten.
2. Verbindung anlegen/waehlen mit diesen Parametern:
   - Hostname: ${host_for_workbench}
   - Port: ${port_for_workbench}
   - Username: ${user_for_workbench}
3. Menue: \`Database -> Reverse Engineer...\`
4. Das passende Schema aus der Tabelle oben auswaehlen.
5. Import abschliessen, dann im Modell auf EER-Diagramm wechseln.
6. Notation setzen: \`Model -> Relationship Notation -> Connect to Columns\` (wenn verfuegbar).
7. Speichern: \`File -> Save Model As...\` und die Datei auf den jeweiligen Ziel-.mwb-Pfad speichern.

## 3) Validierung einer echten .mwb

Eine echte Workbench-Datei enthaelt intern die Datei \`document.mwb.xml\`.

Beispielpruefung:

\`unzip -l <datei>.mwb | grep document.mwb.xml\`

Wenn kein Treffer kommt, ist die Datei kein natives Workbench-Modell.
EOF

echo "[prepare-mwb] Fertig: ${processed} System(e) vorbereitet"
echo "[prepare-mwb] Guide: ${output_guide}"

if [[ $errors -gt 0 ]]; then
  echo "[prepare-mwb] Hinweis: ${errors} System(e) wegen fehlender Daten-Datei uebersprungen"
fi
