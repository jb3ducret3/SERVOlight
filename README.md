
🔧 Installation de Git :

Copy code
sudo apt install git
Cette commande installe Git sur le système. Git est un système de contrôle de version qui sera utilisé pour cloner le dépôt de l'application.

📂 Clonage du Dépôt de l'Application :

bash
Copy code
git clone https://github.com/jb3ducret3/SERVOlight.git
Cette commande clone le dépôt de l'application SERVOlight depuis GitHub vers le répertoire local de l'utilisateur.

▶️ Lancement de l'Application :

bash
Copy code
chmod +x menu.sh
./menu.sh
Ces commandes rendent le script menu.sh exécutable, puis le lancent. Le script menu.sh est un script de menu interactif qui offre différentes options pour gérer l'application.

Configuration :
🐍 Flask App (Python) :

Utilise Flask pour créer une application web.
Crée une base de données SQLite pour stocker les données de l'inventaire.
Expose des routes pour ajouter, afficher, rechercher et supprimer des entrées dans l'inventaire.
Permet d'exporter les données de l'inventaire au format CSV et PDF.
🐳 Docker Compose Configuration :

Utilise Docker Compose pour gérer les conteneurs nécessaires à l'application.
Configure les services Traefik, inventairedb et dnsserver.
Utilisateur :
🌐 Interface Web (HTML/Flask) :

Permet à l'utilisateur d'accéder à l'application via un navigateur web.
Affiche un formulaire pour saisir de nouvelles entrées dans l'inventaire.
Affiche les entrées de l'inventaire sous forme de tableau avec la possibilité de supprimer chaque entrée.
Permet à l'utilisateur d'exporter les données de l'inventaire au format CSV et PDF.
Administrateur :
🛠️ Menu Bash (Shell Script) :

Offre une interface en ligne de commande pour l'administrateur.
Permet à l'administrateur d'installer l'application, de récupérer les données, de démarrer, d'arrêter et de redémarrer l'application, ainsi que de supprimer tous les conteneurs Docker.
🐋 Gestion des Conteneurs (Docker) :

L'administrateur peut utiliser Docker pour gérer les conteneurs nécessaires à l'application.
Peut démarrer, arrêter, redémarrer et supprimer tous les conteneurs Docker à l'aide des scripts fournis.
Avantages de la Conteneurisation :
📦 Portabilité : Les conteneurs encapsulent tous les éléments nécessaires à l'exécution d'une application, y compris les dépendances et les bibliothèques. Cela rend l'application portable, facilitant ainsi son déploiement sur différentes plateformes et environnements.

🔒 Isolation : Chaque conteneur fonctionne de manière isolée, ce qui signifie que les changements ou les erreurs survenant dans un conteneur n'affectent pas les autres. Cela permet de maintenir la stabilité et la sécurité de l'ensemble du système.

🔄 Gestion Simplifiée : Les outils de gestion des conteneurs, tels que Docker, offrent des fonctionnalités pour créer, déployer, surveiller et mettre à jour facilement les applications. Cela simplifie le processus de gestion des applications, notamment lorsqu'il s'agit de déploiements à grande échelle.

💡 Efficacité des Ressources : Les conteneurs partagent le noyau du système hôte, ce qui réduit les besoins en ressources par rapport aux machines virtuelles. Cela permet d'optimiser l'utilisation des ressources matérielles et d'exécuter plusieurs instances d'application sur une seule machine.

Avantages de SQLite :
🔍 Léger et Facile à Configurer : SQLite est une base de données légère et simple à configurer. Il fonctionne en tant que bibliothèque embarquée dans l'application, ce qui signifie qu'aucun processus serveur distinct n'est nécessaire pour l'exécuter.

🛠️ Pas de Configuration ou Maintenance Serveur : Étant donné qu'il n'y a pas de serveur distinct, il n'y a pas besoin de configuration ou de maintenance du serveur. Cela réduit la complexité et les coûts associés à la gestion d'une base de données.

🔧 Fonctionnalités Complètes : Bien que léger, SQLite offre de nombreuses fonctionnalités de base de données relationnelle, telles que les transactions ACID, les contraintes de clé étrangère, les index, etc. Il peut prendre en charge de nombreuses opérations de base de données sans sacrifier la performance.

🌍 Portabilité : Comme SQLite stocke la base de données dans un seul fichier, il est facilement portable entre différents environnements et systèmes d'exploitation. Cela facilite le partage et la distribution de l'application avec sa base de données.

