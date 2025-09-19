# Script: Test-EICARInMemory.ps1
# Objectif : Télécharger EICAR encodé en base64 et l'utiliser en mémoire
# Auteurs : hervetv + assistant
# Environnement : LAB SEULEMENT

Write-Host "[*] Téléchargement de l’EICAR encodé en base64 depuis GitHub..."

# 1. URL du fichier EICAR encodé
$url = "https://raw.githubusercontent.com/hervetv/testlab/4310b30215341bebdd3497dd3d0d47bae9a47a90/EICARb64.txt"

try {
    $base64 = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty Content
    Write-Host "[+] Fichier récupéré avec succès.`n"
} catch {
    Write-Error "[-] Échec du téléchargement. Vérifie l'URL ou la connectivité réseau."
    exit 1
}

# 2. Décodage Base64
try {
    $bytes = [Convert]::FromBase64String($base64)
    $decoded = [System.Text.Encoding]::ASCII.GetString($bytes)
    Write-Host "[+] Décodage réussi.`n"
} catch {
    Write-Error "[-] Erreur lors du décodage base64."
    exit 1
}

# 3. Vérification de la signature EICAR
if ($decoded -match "X5O!P%@AP") {
    Write-Host "[!] Signature EICAR détectée en mémoire."
    Write-Host "[!] Le contenu ne sera pas écrit sur disque pour éviter déclenchement AV.`n"
}

# 4. Optionnel : Écrire et exécuter le fichier (commenté par défaut)
<# 
$path = "$env:TEMP\eicar.com"
Set-Content -Path $path -Value $decoded -Encoding ASCII
Start-Process $path
#>

Write-Host "[*] Test terminé. Aucun fichier malveillant n'a été écrit sur disque.`n"
