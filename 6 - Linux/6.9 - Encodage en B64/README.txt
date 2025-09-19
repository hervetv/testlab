README - Tests "encodage en b64" pour Trend Micro ServerProtect for Linux
========================================================================

Description concise des 4 tests
------------------------------
1) encodage_b64.sh
   Script Bash simple (base64)
   Le script contient une chaîne base64 (non lisible en clair) puis la décode pour créer le fichier /tmp/tm_b64_test.txt.
   Exécution :
     chmod +x encodage_b64.sh && ./encodage_b64.sh
   Vérification rapide :
     xxd -p /tmp/tm_b64_test.txt  -> devrait montrer l’UTF-8 de la chaîne cible.
     ou cat /tmp/tm_b64_test.txt pour voir le contenu (affichera la chaîne en clair).

2) encodage_b64_fragmented.sh
   Script Bash (base64 fragmenté)
   Le script assemble la chaîne base64 à partir de fragments (réduit la visibilité d'un motif continu) puis la décode en /tmp/tm_b64_test_fragmented.txt.
   Exécution :
     chmod +x encodage_b64_fragmented.sh && ./encodage_b64_fragmented.sh
   Vérification :
     xxd -p /tmp/tm_b64_test_fragmented.txt
     ou cat /tmp/tm_b64_test_fragmented.txt

3) encodage_b64.py
   Script Python (base64)
   Le script décode une chaîne base64 et écrit le contenu binaire dans /tmp/tm_b64_test_py.txt. Affiche le sha256 du contenu.
   Exécution :
     chmod +x encodage_b64.py && ./encodage_b64.py
     ou python3 encodage_b64.py
   Vérification :
     sha256sum /tmp/tm_b64_test_py.txt
     cat /tmp/tm_b64_test_py.txt

4) encodage_hex.sh
   Script Bash (méthode hex construite dynamiquement)
   Plutôt que d’inclure la séquence hex en clair, le script décode la même base64 interne puis reconstruit les octets via une transformation hex -> \x.. pour écrire /tmp/tm_hex_test.txt.
   Exécution :
     chmod +x encodage_hex.sh && ./encodage_hex.sh
   Vérification :
     xxd -p /tmp/tm_hex_test.txt
     ou cat /tmp/tm_hex_test.txt

Fichiers inclus
---------------
- README.txt
- encodage_b64.sh
- encodage_b64_fragmented.sh
- encodage_b64.py
- encodage_hex.sh
- run_all.sh
- cleanup.sh

Prérequis
---------
- Machine Linux avec accès shell où Trend Micro ServerProtect est installé.
- Permissions pour écrire dans /tmp (ou modifier la variable `out` dans les scripts).
- Python 3 (pour le script Python).

Usage rapide
-----------
1) Rendre les scripts exécutables :
   chmod +x *.sh
   chmod +x encodage_b64.py

2) Exécuter un script isolé, par exemple :
   ./encodage_b64.sh

   ou lancer tous les tests :
   ./run_all.sh

Vérifications utiles (exemples)
------------------------------
- lister les fichiers : ls -l /tmp/tm_*_test*.txt
- afficher le contenu : cat /tmp/tm_b64_test.txt
- afficher en hex : xxd -p /tmp/tm_b64_test.txt
- calculer hash : sha256sum /tmp/tm_b64_test.txt
- noter l'horodatage UTC pour corrélation logs : date -u +"%Y-%m-%dT%H:%M:%SZ"

Nettoyage
---------
Exécuter : ./cleanup.sh
ou manuellement : rm -f /tmp/tm_*_test*.txt

Remarques
--------
- Les scripts n'affichent pas la chaîne cible en clair.
- Tu peux modifier la variable `out` dans chaque script pour tester d'autres chemins (ex: /var/tmp ou un home).
- Si tu veux que j’intègre un scan CLI Trend Micro dans `run_all.sh`, donne-moi la commande/chemin exact et je la rajoute.
