#!/usr/bin/env bash
set -euo pipefail
 
WEBROOT="/var/www/html/avtest"
LAB="/opt/avtest_web"
LOG="$LAB/avtest.log"
mkdir -p "$WEBROOT" "$LAB"
 
echo "[*] Génération EICAR & variantes" | tee -a "$LOG"
printf '%s' 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' > "$LAB/eicar.com"
cp "$LAB/eicar.com" "$WEBROOT/index.php"          # EICAR dans un “fichier web”
cp "$LAB/eicar.com" "$WEBROOT/index.txt"
cp "$LAB/eicar.com" "$LAB/eicar.bin"
 
echo "[*] Archives (simple, imbriquée, chiffrée)" | tee -a "$LOG"
( cd "$LAB" && zip -q eicar.zip eicar.com )
( cd "$LAB" && zip -q inner.zip eicar.com && zip -q nested.zip inner.zip )
( cd "$LAB" && zip -q -P infected eicar_protected.zip eicar.com )
 
echo "[*] Fichier PHP inoffensif avec *marqueurs* (strings uniquement)" | tee -a "$LOG"
cat > "$WEBROOT/dummy_web.php" <<'PHP'
<?php
// Fichier inoffensif pour TEST AV : uniquement des chaînes, pas d'exécution.
// Marques courantes vues dans des webshells (strings dans des commentaires) :
/*
eval(
base64_decode(
shell_exec(
system(
assert(
passthru(
preg_replace(/e,
*/
echo "dummy";
PHP
 
echo "[*] Variante avec chaîne de test personnalisée" | tee -a "$LOG"
echo 'WEBSHELL_TEST_MARKER' >> "$WEBROOT/dummy_web.php"
 
echo "[*] ZIP du contenu web (pour tester scan d’archives de dépôts applicatifs)" | tee -a "$LOG"
( cd "$(dirname "$WEBROOT")" && zip -qr "$LAB/webroot.zip" "$(basename "$WEBROOT")" )
 
echo "[*] Tentatives d'accès local (déclenche on-read si activé)" | tee -a "$LOG"
curl -fsS "http://localhost/avtest/index.php" >/dev/null 2>>"$LOG" || true
curl -fsS "http://localhost/avtest/dummy_web.php" >/dev/null 2>>"$LOG" || true
 
echo "[*] (Optionnel) Scan ClamAV si présent" | tee -a "$LOG"
if command -v clamscan >/dev/null 2>&1; then
  # Signature locale simple basée sur notre chaîne contrôlée
  echo 'Webshell-Test:0:*:574542534C4C5F544553545F4D41524B4552' > "$LAB/webshell_test.ndb" # "WEBSHELL_TEST_MARKER" en hex
  clamscan -d "$LAB/webshell_test.ndb" -r "$WEBROOT" "$LAB" | tee -a "$LOG" || true
else
  echo "[!] clamscan non trouvé : ignore ce bloc ou teste avec ton AV" | tee -a "$LOG"
fi
 
echo "[*] Terminé. Vérifie les alertes de ton AV/EDR et les logs." | tee -a "$LOG"
echo "[i] Nettoyage : sudo rm -rf $WEBROOT $LAB"
