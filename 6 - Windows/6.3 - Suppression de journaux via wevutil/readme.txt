
Ce test necessitant des droits administrateur, l'interet est limité


##############################################
# Test Anti-Forensic - wevtutil Log Disable  #
##############################################

📌 Objectif :
Simuler la désactivation d’un journal d’événements Windows
via `wevtutil`, et observer la réaction de Trend Micro
Deep Security / Apex One / Vision One.

📍 Commande utilisée :
wevtutil sl "Microsoft-Windows-PowerShell/Operational" /e:false

✅ Requiert : Invite de commandes avec privilèges administrateur

🧪 Étapes :
1. Exécute la commande ci-dessus pour désactiver le log.
2. Surveille les alertes dans Trend Micro.
3. Vérifie les journaux de détection ou corrélation MITRE.

🧼 Nettoyage :
wevtutil sl "Microsoft-Windows-PowerShell/Operational" /e:true

⚠️ À ne tester que dans des environnements isolés et autorisés.

####################################################
Étape 1 – Choisir un log pertinent pour la détection
Tu peux tester avec les logs suivants :
Nom du log	Intérêt
Security	Très surveillé par les AV/EDR (mais nécessite admin)
System	Général, visible pour beaucoup de softs
Microsoft-Windows-PowerShell/Operational	Important pour détection de scripts
Microsoft-Windows-WMI-Activity/Operational	Très utile pour traquer les scripts malveillants
Microsoft-Windows-IKE/Operational	Souvent utilisé comme exemple, mais peu critique
Exemple recommandé pour un test de détection :
wevtutil sl "Microsoft-Windows-PowerShell/Operational" /e:false



Étape 2 – Exécuter la commande avec droits élevés (admin)
Tu dois ouvrir une invite de commandes en tant qu’administrateur sinon tu auras :
Access is denied.
Commande :
wevtutil sl "Microsoft-Windows-PowerShell/Operational" /e:false