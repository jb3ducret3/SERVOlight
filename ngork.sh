#!/bin/bash

# Configuration de votre token ngrok (remplacez "your_ngrok_authtoken" par votre token réel)
NGROK_TOKEN="your_ngrok_authtoken"

# Le port que votre application locale utilise
LOCAL_PORT=8888

# Vérification et installation de jq si nécessaire
if ! command -v jq &> /dev/null; then
    echo "jq n'est pas installé. Installation en cours..."
    sudo apt-get update && sudo apt-get install -y jq
fi

# Installation de ngrok si ce n'est pas déjà fait
if ! command -v ngrok &> /dev/null; then
    echo "ngrok n'est pas installé. Téléchargement et installation..."
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    unzip ngrok-stable-linux-amd64.zip
    sudo mv ngrok /usr/local/bin/
    rm ngrok-stable-linux-amdome.zip
fi

# Authentifier votre session ngrok (uniquement nécessaire si pas déjà configuré)
ngrok authtoken $NGROK_TOKEN

# Démarrer ngrok en arrière-plan sur le port local spécifié
ngrok http $LOCAL_PORT > /dev/null &

# Donner un peu de temps à ngrok pour se lancer et établir une connexion
sleep 10

# Récupérer l'URL ngrok en utilisant l'API de ngrok
NGROK_URL=$(curl --silent http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[] | select(.proto=="http") | .public_url')

# Afficher l'URL
echo "Votre URL ngrok est: $NGROK_URL"

# Gardez le script en attente si vous souhaitez garder la session ngrok active
echo "Appuyez sur [CTRL+C] pour arrêter le tunnel..."
wait
