#!/usr/bin/env python3
# encodage_b64.py
# objectif: écrire un fichier décodé à partir d'une chaîne base64 (pas de plaintext dans le script)

import base64
from pathlib import Path
import hashlib

b64 = "WDVPIVAlQEFQWzRcUFpYNTQoUF4pN0NDKTd9JEVJQ0FSLVNUQU5EQVJELUFOVElWSVJVUy1URVNULUZJTEUhJEgrSCo="
data = base64.b64decode(b64)

out = Path("/tmp/tm_b64_test_py.txt")
out.write_bytes(data)

sha256 = hashlib.sha256(data).hexdigest()
print(f"Fichier créé : {out} (taille: {out.stat().st_size} bytes)")
print(f"SHA256: {sha256}")
