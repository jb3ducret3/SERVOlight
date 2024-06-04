#!/bin/bash

# Configuration de votre token ngrok (remplacez "your_ngrok_authtoken" par votre token réel)
NGROK_TOKEN="your_ngrok_authtoken"
LOCAL_PORT=8888

# Fonction pour installer l'application
installer_application() {
    echo "Installation de l'application..."
    chmod +x lancement.sh
    ./lancement.sh
    echo "L'application a été installée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour récupérer les données
recuperer_donnees() {
    echo "Récupération des données..."
    chmod +x recuperationDATA.sh
    ./recuperationDATA.sh
    echo "Les données ont été récupérées avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour démarrer l'application
demarrer_application() {
    echo "Démarrage de l'application..."
    docker stack deploy -c docker-compose.yml mystack
    echo "L'application a été démarrée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour arrêter l'application
arreter_application() {
    echo "Arrêt de l'application..."
    docker stack rm mystack
    echo "L'application a été arrêtée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour redémarrer l'application
redemarrer_application() {
    echo "Redémarrage de l'application..."
    docker stack rm mystark
    docker stack deploy -c docker-compose.yml mystack
    echo "L'application a été redémarrée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour supprimer tous les conteneurs
supprimer_tous_conteneurs() {
    echo "Suppression de tous les conteneurs..."
    docker container prune -f
    echo "Tous les conteneurs ont été supprimés avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour vérifier l'état du cluster
verifier_etat_cluster() {
    echo "Vérification de l'état du cluster..."
    docker node ls
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour ajouter un nœud worker
ajouter_worker() {
    echo "Ajout d'un nœud worker..."
    read -p "Entrez l'adresse IP du manager : " MANAGER_IP
    read -p "Entrez le jeton de jointure du worker : " JOIN_TOKEN
    docker swarm join --token $JOIN_TOKEN $MANAGER_IP:2377
    echo "Nœud worker ajouté avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour démarrer Ngrok
demarrer_ngrok() {
    echo "Démarrage de Ngrok..."
    ngrok authtoken $NGROK_TOKEN
    ngrok http $LOCAL_PORT > /dev/null &
    sleep 10
    NGROK_URL=$(curl --silent http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
    echo "Votre URL ngrok est: $NGROK_URL"
}

# Fonction pour afficher le menu principal
afficher_menu() {
    clear
    echo "Menu Principal"
    echo "1. Installer l'application"
    echo "2. Récupérer les données"
    echo "3. Démarrer l'application"
    echo "4. Arrêter l'application"
    echo "5. Redémarrer l'application"
    echo "6. Supprimer tous les conteneurs"
    echo "7. Vérifier l'état du cluster"
    echo "8. Ajouter un nœud worker"
    echo "9. Quitter"
    echo "10. Démarrer Ngrok"
    echo "Entrez votre choix : "
}

# Boucle principale du menu
while true; do
    afficher_menu
    read choix
    case $choi in
        1) installer_application ;;
        2) recuperer_donnees ;;
        3) demarrer_application ;;
        4) arreter_application ;;
        5) redemarrer_application ;;
        6) supprimer_tous_conteneurs ;;
        7) verifier_etat_cluster ;;
        8) ajouter_worker ;;
        9) exit ;;
        10) demarrer_ngrok ;;
        *) echo "Choix invalide. Veuillez saisir un nombre entre 1 et 10." ;;
    esac
done
