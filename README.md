# flutter_clicker_game

## Description du Projet

 Ce jeu de clicker, est une application Android développée avec Flutter et Dart. Elle permet aux joueurs de gérer un stock de ressources à collecter et à dépenser, notamment le bois, le minerai de fer brut et le minerai de cuivre brut. En cliquant sur ces ressources, les joueurs récoltent des unités, débloquent des recettes et de nouveaux éléments de gameplay.


## Installation

## Prérequis

- Flutter (Dernière version stable)
- Dart SDK (Compatible avec la version de Flutter)

```bash
# Vérification de l'installation
flutter doctor
# Configuration du Projet

# Clonage du repo
git clone [URL du Repo]
cd [Nom du Repo]

# Installation des dépendances
flutter pub get

# Lancer l'application en mode développement
flutter run
# ou compilé en apk
flutter build apk
```

## Fonctionnalités Principales
- Page d'Accueil "Ressources" :
 Utilisation d'un GridView pour présenter les ressources avec un bouton "Miner" pour récolter des ressources.

- Navigation vers "Recettes" :   
Affichage des recettes disponibles et production d'objets en fonction des ressources disponibles.

- Navigation vers "Inventaire" :   
 Affichage des items produits avec des options de tri par nom ou quantité.

- Déblocage de Ressources :     
Nouvelles ressources telles que le Charbon se débloquent en atteignant certains objectifs.

- Automatisation de la Production :     
  Implémentation de Mineurs et Fonderies pour l'automatisation de la production.

#### Licence   
Ce projet est distribué sous la licence MIT. Voir le fichier LICENSE pour plus d'informations.

#### Contact

Morvan Etienne - etienne.morvan@hotmail.fr   
Site Web - https://etiennemorvan.com