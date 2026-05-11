#!/usr/bin/env bash
set -euo pipefail

input_dir="generated/klassenarbeiten"
force_flag=""
python_bin="python3"

if [[ -x "/workspaces/edu-code-course-rdb/.venv/bin/python" ]]; then
  python_bin="/workspaces/edu-code-course-rdb/.venv/bin/python"
fi

if [[ "${1:-}" == "--force" ]]; then
  force_flag="--force"
fi

echo "[ka-eerm-assets] Starte Artefakt-Workflow..."
echo "[ka-eerm-assets] Schritt 1/2: PNG-Generierung"

"$python_bin" scripts/plugins/eerm_grafik_generator/generate_eerm_png.py \
  --input-dir "$input_dir" \
  --strict-plus \
  --a4-portrait \
  --max-columns 2 \
  $force_flag

echo "[ka-eerm-assets] Schritt 2/2: PNG-Referenzen in Markdown einbetten"

"$python_bin" scripts/plugins/eerm_grafik_generator/embed_eerm_png_reference.py \
  --markdown-dir "$input_dir"

echo "[ka-eerm-assets] Fertig"