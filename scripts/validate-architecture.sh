#!/usr/bin/env bash
set -euo pipefail

fail=0

note_fail() {
  echo "[arch] FAIL: $1"
  fail=1
}

echo "[arch] Starte Architekturvalidierung..."

# Java-Basis-Check
./scripts/test-java.sh

# OOP-Guardrails: Keine mutierenden Setter fuer interne Teamlisten
if grep -nE "setStartaufstellung\(|setErsatzBank\(" src/volleyball/VolleyballspielerTeamManager.java >/dev/null 2>&1; then
  note_fail "Model kapselt interne Listen nicht sauber (mutierende Setter gefunden)."
fi

# Null-Sentinel im Model vermeiden
if grep -nE "default:[[:space:]]*return[[:space:]]+null;" src/volleyball/VolleyballspielerTeamManager.java >/dev/null 2>&1; then
  note_fail "Model liefert null als Kontrollflusswert (bitte leere Sammlung/Exception nutzen)."
fi

if [[ $fail -ne 0 ]]; then
  echo "[arch] Architekturvalidierung fehlgeschlagen"
  exit 1
fi

echo "[arch] Architekturvalidierung erfolgreich"
