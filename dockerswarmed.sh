#!/bin/bash

# Initialisation du cluster Docker Swarm sur le nœud maître
docker swarm init

# Récupération du token du nœud maître
worker_token=$(docker swarm join-token worker -q)

# Adresse IP du nœud maître
master_ip=$(hostname -I | awk '{print $1}')

# Adresse IP du nœud esclave
slave_ip="<nœud_esclave_IP>"

# Vérification de l'existence du nœud esclave
if [ -z "$slave_ip" ]; then
    echo "Erreur: Veuillez spécifier l'adresse IP du nœud esclave."
    exit 1
fi

# Vérification de l'état du cluster Docker Swarm
docker node ls

# Déploiement du stack Docker avec le fichier docker-compose.yml
docker stack deploy -c docker-compose.yml servo

# Mise à l'échelle du service "inventairedb" à 2 instances
docker service scale servo_inventairedb=2

# Vérification des services déployés
docker service ls

# Demande de configuration SSH vers le worker
read -p "Avez-vous configuré la connexion SSH vers le worker ? (o/N) " answer
if [[ "$answer" != "o" ]]; then
    # Connexion au nœud esclave et ajout au cluster Docker Swarm
    # Remplacez <utilisateur> par l'utilisateur SSH du nœud esclave
    # et <mot_de_passe> par le mot de passe de l'utilisateur SSH
    sshpass -p '<mot_de_passe>' ssh <utilisateur>@$slave_ip "docker swarm join --token $worker_token $master_ip:2377"

    exit 0
fi
