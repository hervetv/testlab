#!/usr/bin/env bash
# encodage_hex.sh
# objectif: écrire le même contenu via une reconstruction hex dynamique
#           (on n'inscrit pas la chaîne en clair ni la séquence hex en dur)

set -euo pipefail

b64="WDVPIVAlQEFQWzRcUFpYNTQoUF4pN0NDKTd9JEVJQ0FSLVNUQU5EQVJELUFOVElWSVJVUy1URVNULUZJTEUhJEgrSCo="
out="/tmp/tm_hex_test.txt"

# Décoder base64 en binaire, puis convertir en hex, puis retransformer en \x.. pour écrire
hex=$(printf "%s" "$b64" | base64 -d | xxd -p -c 256)
# Transformer "58656C..." en "\x58\x65\x6C..."
escaped=$(echo "$hex" | sed 's/../\\x&/g')
printf "%b" "$escaped" > "$out"

echo "Fichier créé : $out"
echo "Taille (bytes): $(stat -c%s "$out")"
echo "SHA256: $(sha256sum "$out" | awk '{print $1}')"
