# TourCam 360 - Explication du Code Source

## Introduction

TourCam 360 est une application mobile Flutter conçue pour aider les utilisateurs à découvrir des lieux touristiques au Cameroun, en particulier dans la région de l'Ouest. Elle vise à offrir une expérience utilisateur immersive avec des suggestions de lieux basées sur les préférences, une navigation cartographique et, à terme, des fonctionnalités de reconnaissance d'image et de météo adaptative.

## Structure du Projet

Le code source de l'application est principalement organisé dans le dossier `lib/`. Voici une description des sous-dossiers et fichiers clés :

*   `lib/`
    *   **`main.dart`**: C'est le point d'entrée principal de l'application Flutter. Il initialise l'application et configure le thème global ainsi que la navigation initiale vers `MainScaffoldWithBottomNavbar`.
    *   **`screens/`**: Ce dossier contient les différentes "pages" ou "vues" de l'application. Chaque fichier correspond généralement à un écran distinct que l'utilisateur peut voir.
        *   `main_scaffold.dart` (`MainScaffoldWithBottomNavbar`): Le conteneur principal de l'application après le démarrage. Il gère la `BottomNavigationBar` et l'affichage des pages associées à chaque onglet.
        *   `new_home_screen.dart` (`NewHomeScreen`): Le nouvel écran d'accueil (actuellement sur l'onglet "Itinéraire"). Il présente un carrousel de lieux et est conçu pour un fond adaptatif.
        *   `itinerary_preferences_page.dart` (`ItineraryPreferencesPage`): Permet à l'utilisateur de sélectionner ses préférences de voyage (ex: Nature, Culture). (Actuellement non directement accessible depuis `NewHomeScreen`, mais le flux est prévu).
        *   `suggested_places_page.dart` (`SuggestedPlacesPage`): Affiche une liste de lieux suggérés (filtrés par l'API ou anciennement par des données fictives) en fonction des préférences de l'utilisateur. Gère les états de chargement (avec un effet shimmer) et d'erreur.
        *   `map_display_page.dart` (`MapDisplayPage`): Affiche une carte Google Maps centrée sur un lieu spécifique, avec un marqueur.
        *   `profile_page.dart` (`ProfilePage`): Page placeholder pour le profil utilisateur.
        *   `image_recognition_page.dart` (`ImageRecognitionPage`): Page placeholder pour la fonctionnalité de reconnaissance d'image (onglet central par défaut).
        *   `stats_page.dart` (`StatsPage`): Page placeholder pour les statistiques.
    *   **`widgets/`**: Contient les composants d'interface utilisateur réutilisables à travers différentes parties de l'application.
    *   **`models/`**: Définit les structures de données (modèles) utilisées dans l'application.
        *   `place.dart` (`Place`): Modèle pour un lieu touristique, incluant nom, description, catégorie, coordonnées, URL d'image. Contient une factory `fromJson` pour le parsing des données API et une méthode `toMap` pour la navigation.
        *   `user_preferences.dart` (`UserPreferences`): Modèle pour encapsuler les préférences de l'utilisateur et les convertir en paramètres de requête pour l'API.
    *   **`services/`**: Contient la logique métier, notamment la communication avec des services externes comme l'API.
        *   `api_service.dart` (`ApiService`): Gère les appels à l'API Django pour récupérer les lieux suggérés. Contient une URL de base qui doit être configurée.
    *   **`utils/`**: Regroupe les fichiers utilitaires et les constantes.
        *   `constants.dart`: Définit les constantes globales, notamment la palette de couleurs de l'application (`kPrimaryColor`, `kSecondaryColor`, `kNeutralColor`).
        *   `fade_page_route.dart` (`FadePageRoute`): Une classe de route personnalisée pour créer des transitions de page avec un effet de fondu.

## Flux de Données Principal (Exemple: Itinéraire)

Le flux de découverte d'itinéraire est un exemple central du fonctionnement de l'application :

1.  **Écran d'Accueil Immersif (`NewHomeScreen`)**: L'utilisateur commence sur cet écran (actuellement le premier onglet "Itinéraire"). Il voit un carrousel de lieux. En cliquant sur "En savoir plus" pour un lieu, il navigue vers `MapDisplayPage` pour ce lieu.
    *   *(Transition vers les préférences)*: Idéalement, `NewHomeScreen` contiendrait un bouton ou une action pour naviguer vers `ItineraryPreferencesPage`. (Cette navigation spécifique n'est pas encore implémentée dans `NewHomeScreen`).
2.  **Sélection des Préférences (`ItineraryPreferencesPage`)**: Si l'utilisateur accède à cet écran (par exemple, via un futur bouton sur `NewHomeScreen` ou si c'était la page principale de l'onglet), il peut cocher des cases correspondant à ses intérêts (Nature, Culture, etc.).
3.  **Passage des Préférences**: Lorsqu'il clique sur "Voir les suggestions", un objet `UserPreferences` est créé et passé à la page `SuggestedPlacesPage`.
4.  **Récupération des Lieux (`SuggestedPlacesPage`)**:
    *   Au chargement, `SuggestedPlacesPage` affiche un effet de chargement "shimmer".
    *   Elle utilise `ApiService` pour envoyer les préférences de l'utilisateur à l'API Django.
    *   L'API (hypothétique) retourne une liste de lieux correspondants.
5.  **Affichage des Suggestions**:
    *   Si l'appel API réussit, les lieux sont affichés dans une `ListView`. Chaque élément montre le nom, la catégorie et une image (si l'URL est valide).
    *   Si l'appel échoue, un message d'erreur est affiché.
    *   Si aucun lieu ne correspond, un message approprié est également montré.
6.  **Navigation vers la Carte (`MapDisplayPage`)**: En cliquant sur un lieu dans la liste, l'utilisateur navigue vers `MapDisplayPage`, qui reçoit les données du lieu (via la méthode `place.toMap()`) et affiche sa position sur une carte Google Maps.

## Personnalisation et Points Clés

*   **Thème Global**: Le fichier `main.dart` configure un `ThemeData` global, qui définit l'apparence de l'application (couleurs, styles de boutons, etc.). Les couleurs principales (`kPrimaryColor`, etc.) sont définies dans `lib/utils/constants.dart`.
*   **Navigation**: La navigation entre les écrans est gérée par `Navigator.of(context).push()`. Une transition personnalisée `FadePageRoute` est utilisée pour un effet de fondu. La navigation par onglets est gérée par `MainScaffoldWithBottomNavbar`.
*   **Gestion d'État Simple**: L'état est principalement géré localement dans les `StatefulWidget` en utilisant `setState()` pour reconstruire l'interface utilisateur après un changement de données (ex: sélection d'une préférence, réception de données API).

## Intégration API (Points à Noter)

*   **Configuration de l'URL de l'API**: Le fichier `lib/services/api_service.dart` contient une variable `_baseUrl` avec une URL placeholder (`https://votre-api-django.com/api`). **Celle-ci DOIT être remplacée par l'URL réelle de votre backend Django pour que les appels API fonctionnent.**
*   **Clés API Google Maps**: Pour que `GoogleMap` s'affiche correctement (avec les tuiles de carte), des clés API Google Maps valides doivent être configurées pour Android et iOS :
    *   **Android**: Dans `android/app/src/main/AndroidManifest.xml`.
    *   **iOS**: Dans `ios/Runner/AppDelegate.swift`.
    Ces clés ne sont pas incluses dans le code source et doivent être ajoutées par le développeur.

## Commentaires dans le Code

La majorité des commentaires dans le code source Dart (fichiers `.dart`) ont été traduits ou écrits en français pour faciliter la compréhension et la maintenance du projet par des développeurs francophones.

---

Ce document fournit un aperçu. Pour des détails plus spécifiques, veuillez vous référer aux commentaires dans les fichiers de code source respectifs.
