#!/bin/bash

# Fonction pour vérifier si une commande a échoué
check_error() {
    if [ $? -ne 0 ]; then
        echo "Erreur: $1"
        exit 1
    fi
}

# Nettoyer le cache et mettre à jour le système
sudo apt clean
sudo apt update -y
sudo apt upgrade -y

# Installer Docker et Docker Compose
sudo apt install docker.io -y
sudo apt install docker-compose -y

# Installer Python et ses dépendances
sudo apt-get install python3-venv -y 
sudo apt install python3-pip -y 
mkdir PDF_CSV

# Construire l'image Docker de l'application Python
cd PYTHON
docker build -t inventairedb .
check_error "Erreur lors de la construction de l'image Docker pour l'application Python."

cd ..
# Construire l'image Docker du serveur DNS
cd DNS/
docker build -t dnsserveur .
check_error "Erreur lors de la construction de l'image Docker pour le serveur DNS."

# Revenir au répertoire racine du projet
cd ..

# Initialiser Docker Swarm
echo "Initialisation de Docker Swarm..."
SWARM_MANAGER_IP=$(hostname -I | awk '{print $1}')
docker swarm init --advertise-addr $SWARM_MANAGER_IP
check_error "Échec de l'initialisation de Docker Swarm."

# Déployer la stack Docker Compose avec Docker Swarm
echo "Déploiement de la stack Docker Compose avec Docker Swarm..."
docker stack deploy -c docker-compose.yml mystack
check_error "Échec du déploiement de la stack Docker Compose."

echo "Configuration de Docker Swarm et déploiement de la stack terminés avec succès."
