#!/usr/bin/env bash
# cleanup.sh - supprime les fichiers de test
set -euo pipefail

rm -f /tmp/tm_*_test*.txt
echo "Fichiers supprimés (si présents)."
