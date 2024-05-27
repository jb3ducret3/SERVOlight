#!/bin/bash

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
    echo "7. Quitter"
    echo "Entrez votre choix : "
}

# Fonction pour installer l'application
installer_application() {
    echo "Installation de l'application..."
    # Commande pour exécuter le script d'installation
    chmod +x lancement.sh
    ./lancement.sh
    echo "L'application a été installée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour récupérer les données
recuperer_donnees() {
    echo "Récupération des données..."
    # Commande pour exécuter le script de récupération de données
    chmod +x recuperationDATA.sh
    ./recuperationDATA.sh
    echo "Les données ont été récupérées avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour démarrer l'application
demarrer_application() {
    echo "Démarrage de l'application..."
    # Commande pour démarrer les services Docker Swarm
    docker stack deploy -c docker-compose.yml mystack
    echo "L'application a été démarrée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour arrêter l'application
arreter_application() {
    echo "Arrêt de l'application..."
    # Commande pour arrêter les services Docker Swarm
    docker stack rm mystack
    echo "L'application a été arrêtée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour redémarrer l'application
redemarrer_application() {
    echo "Redémarrage de l'application..."
    # Commande pour redémarrer les services Docker Swarm
    docker stack rm mystack
    docker stack deploy -c docker-compose.yml mystack
    echo "L'application a été redémarrée avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Fonction pour supprimer tous les conteneurs
supprimer_tous_conteneurs() {
    echo "Suppression de tous les conteneurs..."
    # Commande pour supprimer tous les conteneurs Docker
    docker container prune -f
    echo "Tous les conteneurs ont été supprimés avec succès."
    read -p "Appuyez sur Entrée pour continuer..."
}

# Boucle principale du menu
while true; do
    afficher_menu
    read choix
    case $choix in
        1) installer_application ;;
        2) recuperer_donnees ;;
        3) demarrer_application ;;
        4) arreter_application ;;
        5) redemarrer_application ;;
        6) supprimer_tous_conteneurs ;;
        7) exit ;;
        *) echo "Choix invalide. Veuillez saisir un nombre entre 1 et 7." ;;
    esac
done
