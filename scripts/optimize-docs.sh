#!/usr/bin/env bash
set -euo pipefail

echo "[docs-opt] Starte automatische Dokumentationsoptimierung..."
python3 scripts/optimize_docs.py --write
echo "[docs-opt] Verifiziere Struktur nach Optimierung..."
python3 scripts/optimize_docs.py --check
echo "[docs-opt] Dokumentation ist wohlgeformt und konsistent"
