#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "[bootstrap] .env aus .env.example erzeugt"
fi

chmod +x scripts/*.sh

echo "[bootstrap] Fertig. Nutze: ./scripts/start-services.sh"
