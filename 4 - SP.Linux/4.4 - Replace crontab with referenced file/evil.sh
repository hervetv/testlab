#!/bin/bash

# URL de ton serveur distant (changer IP/port selon ton infra)
SERVER_URL="http://192.168.56.1:8000/beacon"

# Données envoyées (ici juste date et hostname)
curl -X POST -d "host=$(hostname)&time=$(date +%s)" "$SERVER_URL"
