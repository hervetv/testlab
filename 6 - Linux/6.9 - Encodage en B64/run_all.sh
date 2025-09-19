#!/usr/bin/env bash
# run_all.sh - exécute tous les tests et affiche un résumé simple

set -euo pipefail

scripts=(
  "./encodage_b64.sh"
  "./encodage_b64_fragmented.sh"
  "./encodage_b64.py"
  "./encodage_hex.sh"
)

echo "Execution des tests : $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
for s in "${scripts[@]}"; do
  echo ">>> Exécution: $s"
  if [[ $s == *.py ]]; then
    python3 "$s"
  else
    bash "$s"
  fi
  echo "----"
done

echo "Listing fichiers créés :"
ls -l /tmp/tm_*_test*.txt || true

echo "SHA256 summary:"
for f in /tmp/tm_*_test*.txt; do
  sha256sum "$f"
done || true

echo "Fin des tests : $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
