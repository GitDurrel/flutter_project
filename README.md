# Hi Jules, besoin de ton aide

Je veux que tu m'aides avec la base de mon application Flutter, plus précisément son **UX/UI**. Voici les consignes à suivre pour la mise en place :

## 🛠️ Environnement de développement
- **IDE utilisé** : **Android Studio**
- **Base du projet** : Application **iOS**
- Android Studio est choisi pour sa gestion **optimisée des dépendances**, sa prise en charge des **API natives**, et ses outils de **profiling avancés** pour le debugging.

## 🎨 1. Palette de couleurs
Palette sélectionnée sur Vimes :
- `#0444BF`
- `#0584F2`
- `#0AAFF1`
- `#EDF259`

Appliquons la **règle du 60-30-10** :
- **Neutre (60%)** : `#EDF259`
- **Primaire (30%)** : `#0584F2`
- **Secondaire (10%) pour Call-to-Action** : `#0AAFF1`

## ✋ 2. ThumbZone & Accessibilité
Respecter les principes de Microsoft :
- Éléments cliquables : **min. 7mm** de taille et **espacés de 2mm**.
- Positionnement adapté aux **zones accessibles** aux pouces.

Ajout de **feedback visuel** :
- **Effets de pression** sur les boutons pour indiquer leur activation.
- **Transitions fluides** entre les écrans (ex. fade in/out).

## 🎯 3. Accent Color
Utiliser la couleur d’accent **uniquement** pour les éléments cliquables.

## 🖼️ 4. Icônes
Utiliser **les icônes natives** d’iOS pour guider l’utilisateur.

Ajouter **du texte alternatif** aux icônes pour **améliorer l’accessibilité**.

## 🔘 5. Harmonie des boutons
Tous les boutons doivent être **uniformes**. Si l’un est arrondi, tous doivent l’être.

## 🧭 6. Fil d'Ariane
Affichage d’un **fil d’Ariane** pour que l’utilisateur sache où il se trouve.

## 🚀 7. Bottom Navbar
- Onglets : **Itinéraire, Profil, Reconnaissance image, Statistiques**.
- **Animation dynamique** : Au clic, la navbar se déconstruit, laissant l’icône au-dessus enveloppée dans un cercle et la navbar en dessous de l'emplacement initiale de l'icône devient creuse (effet engrenage).

Ajouter **gestion des états** :
- **Animations douces** lorsque l’utilisateur navigue entre les onglets.
- **Retour visuel clair** lorsque l’utilisateur sélectionne un onglet actif.

## 🏗️ 8. Pages liées aux icônes
- **Créer l’UI complète des pages**, mais par défaut, **elles doivent être vides** lorsque l’utilisateur y accède via la Bottom Navbar.
- Seule **la page d’accueil** doit être codée dès le départ.

## 🗺️ 9. Fonctionnalité d’itinéraire et carte interactive
### **Étape 1 : Choix des préférences utilisateur**
Lorsque l’utilisateur accède à l’onglet **Itinéraire**, il doit sélectionner **ses préférences** parmi :
- **Nature & paysages**
- **Histoire & culture**
- **Patrimoine local**
- **Tourisme moderne**, etc.

Une API touristique devra être intégrée pour **récupérer les lieux correspondants**.

### **Étape 2 : Suggestions de lieux**
Après sélection des préférences, afficher une **liste de lieux recommandés** selon les données de l’API.  
Chaque suggestion doit être **cliquable** et rediriger vers la **carte interactive**.

### **Étape 3 : Carte interactive avec API**
- Intégrer une **API de cartographie** (**Google Maps API** ou **Mapbox**).
- Afficher les **marqueurs** pour les lieux suggérés.
- Générer un **tracé dynamique** en fonction de l’itinéraire recommandé.
- Mettre à jour les **informations en temps réel** sur les points touristiques sélectionnés.

### **Étape 4 : Mise à jour automatique**
La carte doit être **interactif et dynamique**, avec :
- **Actualisation des données en temps réel** via une API de gestion touristique.
- Option de **zoom et mode satellite** pour une meilleure visibilité.

## 🔄 10. Skeleton Loader
Ajouter une **animation style squelette** au chargement, comme sur les apps modernes.

## 🎡 11. Écran d’accueil
Créer une **page d’accueil attractive** avec :
- **Un slide photo dynamique**.
- **Un onboarding léger** pour introduire les fonctionnalités essentielles.
- **Un mode sombre** pour offrir une alternative visuelle confortable.

---

## 🌍 Contexte du projet

### **TourCam 360 – IA & Tourisme**
L’Intelligence Artificielle au service du tourisme régional pour la **reconnaissance visuelle et la réalité augmentée**.

### 🚧 Problématique
L'essor touristique est freiné par :
- Manque de **diversification des offres**.
- Accès limité aux **données actualisées**.
- Modernisation **insuffisante** des infrastructures.

### 🤖 Solution
L'application TourCam 360 intègre :
✔ **Reconnaissance d’image** pour identifier les sites touristiques.  
✔ **Visite immersive** en réalité augmentée.  
✔ **Collecte et analyse de données** en temps réel.  
✔ **Itinéraire intelligent en temps réel** grâce aux préférences de l'utilisateur.  
✔ **Carte interactive avec API de suggestions et affichage en temps réel**.

### 📊 Impact et perspectives
Notre solution vise à :
- **Faciliter l’accès** à l’information.
- **Optimiser la gestion** des flux touristiques.
- **Moderniser le secteur** avec une approche **data-driven**.

---
