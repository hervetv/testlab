Liste d'outils d'administration/d'accès à distance pouvant etre détectés
Tous sont "légitimes", mais régulièrement utilisés par les attaquants dans des campagnes réelles, ou comme RAT dans des ransomwares/payloads.

🛠️ 1. AnyDesk
Site : https://anydesk.com/
Type : Contrôle à distance
Comportement détectable : connexion à distance persistante, injection dans d’autres processus
✅ Fréquemment détecté si lancé en mode scripté

🛠️ 2. TeamViewer
Site : https://www.teamviewer.com/
Type : Support et accès distant
Fichier commun : TeamViewer_Setup.exe

✅ Certains modules AV bloquent l’exécution si pattern "non interactif"
🛠️ 3. Remote Utilities (RUT)
Site : https://www.remoteutilities.com/
Type : RAT commercial légitime
🛑 Très utilisé dans des campagnes malveillantes
✅ Bloqué par de nombreux AVs par défaut (Trend Micro inclus)

🛠️ 4. Ammyy Admin
Site : https://www.ammyy.com/
Type : Remote desktop (souvent utilisé dans arnaques support)
✅ Souvent marqué comme potentiellement indésirable (PUA/PUP)

🛠️ 5. Atera Agent
Site : https://www.atera.com/
Type : Monitoring & remote support (MSP)
✅ Utilisé par des groupes d’attaquants pour un accès persistant
🛑 Détecté comme PUA/Remote Tool

🛠️ 6. ScreenConnect / ConnectWise Control
Site : https://www.connectwise.com/
Type : Remote admin
🛑 A été utilisé dans des compromissions de MSP
✅ Surveillez les processus ScreenConnect.Client.exe

🛠️ 7. NetSupport Manager / NetSupport RAT
Site : https://www.netsupportsoftware.com/
Type : Légitime, mais très abusé dans les malwares (notamment via JS)
✅ Signatures très fréquentes dans Trend Micro et autres EDR

🛠️ 8. UltraVNC / TightVNC / RealVNC
Type : Outils open-source d’accès distant
✅ Peuvent être détectés selon contexte d'exécution
Utilisation en script sans interface = souvent suspecte

🛠️ 9. Radmin / Radmin Viewer
Site : https://www.radmin.com/
Type : Remote Desktop tool
✅ Connu pour être utilisé dans des attaques post-exploitation

🛠️ 10. Cobalt Strike (beacon launcher) — Simulé uniquement
Non légitime, mais certains faux RATs incluent des stagers c2.exe ou beacon.exe
✅ Deep Security détecte les stagers via : heuristique + Smart Protection Network