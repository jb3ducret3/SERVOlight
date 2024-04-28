#!/bin/bash

# Définir le répertoire du conteneur où se trouvent les fichiers PDF et CSV
CONTAINER_DIR="/app"

# Définir le répertoire du serveur où seront copiés les fichiers PDF et CSV
SERVER_DIR="/home/debian/SERVO_light/inventaire materiel/PDF_CSV"

# Créer un répertoire avec un horodatage pour stocker les fichiers
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
NEW_SERVER_DIR="$SERVER_DIR/$TIMESTAMP"
mkdir -p "$NEW_SERVER_DIR"

# Récupérer l'ID du conteneur inventairedb
CONTAINER_ID=$(docker ps | grep inventairedb | awk '{print $1}')

# Copier tous les fichiers du répertoire du conteneur vers le répertoire local avec l'horodatage
docker cp "$CONTAINER_ID":"$CONTAINER_DIR"/. "$NEW_SERVER_DIR"/
