#!/usr/bin/env bash
# encodage_b64.sh
# objectif: créer /tmp/tm_b64_test.txt en décodant une chaîne base64 (aucun plaintext visible)

set -euo pipefail

# base64 de la chaîne EICAR (pas de texte en clair dans le script)
b64="WDVPIVAlQEFQWzRcUFpYNTQoUF4pN0NDKTd9JEVJQ0FSLVNUQU5EQVJELUFOVElWSVJVUy1URVNULUZJTEUhJEgrSCo="
#    WDVPIVAlQEFQWzRcUFpYNTQoUF4pN0NDKTd9JEVJQ0FSLVNUQU5EQVJELUFOVElWSVJVUy1URVNULUZJTEUhJEgrSCo=
out="/tmp/tm_b64_test.txt"

# crée le fichier en décodant
printf "%s" "$b64" | base64 -d > "$out"

# infos
echo "Fichier créé : $out"
echo "Taille (bytes): $(stat -c%s "$out")"
echo "SHA256: $(sha256sum "$out" | awk '{print $1}')"
