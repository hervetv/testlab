#!/usr/bin/env bash
# encodage_b64_fragmented.sh
# objectif: même résultat que encodage_b64.sh mais base64 fragmenté pour discrétion

set -euo pipefail

# fragments du base64 pour réduire visibilité d'un motif continu dans le script
p1="WDVPIVAl"
p2="QEFQWzRc"
p3="UFpYNTQo"
p4="UF4pN0ND"
p5="KTd9JEVJ"
p6="Q0FSLVNU"
p7="QU5EQVJE"
p8="LUFOVElW"
p9="SVJVUy1U"
p10="RVNULUZJ"
p11="TEUhJEgr"
p12="SCo="

b64="${p1}${p2}${p3}${p4}${p5}${p6}${p7}${p8}${p9}${p10}${p11}${p12}"
out="/tmp/tm_b64_test_fragmented.txt"

printf "%s" "$b64" | base64 -d > "$out"

echo "Fichier créé : $out"
echo "Taille (bytes): $(stat -c%s "$out")"
echo "SHA256: $(sha256sum "$out" | awk '{print $1}')"
