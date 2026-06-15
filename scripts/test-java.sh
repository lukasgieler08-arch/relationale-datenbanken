#!/usr/bin/env bash
set -euo pipefail

mkdir -p build/java
javac -d build/java src/volleyball/*.java

echo "[java] Kompilierung erfolgreich"

echo "[java] Starte Headless-Modell-Smoke-Tests..."
java -cp build/java volleyball.ModelSmokeTest

echo "[java] Modell-Tests erfolgreich"
