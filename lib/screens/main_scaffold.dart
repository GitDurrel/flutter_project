import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'new_home_screen.dart'; // Importation du nouvel écran d'accueil immersif
import 'profile_page.dart'; // Page de profil (onglet "Profil")
import 'image_recognition_page.dart'; // Page de reconnaissance d'image (onglet "Reconnaissance")
import 'stats_page.dart'; // Page de statistiques (onglet "Statistiques")
import '../utils/constants.dart'; // Pour les couleurs globales comme kPrimaryColor.

// StatefulWidget principal qui gère la navigation par onglets (BottomNavigationBar).
class MainScaffoldWithBottomNavbar extends StatefulWidget {
  const MainScaffoldWithBottomNavbar({super.key});

  @override
  State<MainScaffoldWithBottomNavbar> createState() =>
      _MainScaffoldWithBottomNavbarState();
}

class _MainScaffoldWithBottomNavbarState
    extends State<MainScaffoldWithBottomNavbar> {
  // Index de l'onglet actuellement sélectionné.
  // Initialisé à 2 pour que l'onglet "Reconnaissance image" (le troisième, index 2) soit sélectionné par défaut.
  int _selectedIndex = 2;

  // Liste statique des widgets (pages) à afficher pour chaque onglet.
  // L'ordre correspond à celui des BottomNavigationBarItem.
  static const List<Widget> _pages = <Widget>[
    NewHomeScreen(), // Onglet 0: Nouvel accueil immersif (remplace ItineraryPreferencesPage ici)
    ProfilePage(), // Onglet 1: Profil
    ImageRecognitionPage(), // Onglet 2: Reconnaissance image
    StatsPage(), // Onglet 3: Statistiques
  ];

  // Callback appelé lorsque l'utilisateur appuie sur un onglet de la BottomNavigationBar.
  // Met à jour l'_selectedIndex pour afficher la page correspondante.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le corps du Scaffold affiche la page correspondant à l'index sélectionné.
      body: _pages[_selectedIndex],
      // Barre de navigation inférieure.
      bottomNavigationBar: BottomNavigationBar(
        // Liste des éléments (onglets) de la barre de navigation.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map_pin_ellipse), // Icône pour l'itinéraire.
            label: 'Itinéraire', // Libellé de l'onglet.
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled), // Icône pour le profil.
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.camera_viewfinder), // Icône pour la reconnaissance d'image.
            label: 'Reconnaissance', // Libellé raccourci pour un meilleur affichage.
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_square), // Icône pour les statistiques.
            label: 'Statistiques',
          ),
        ],
        currentIndex: _selectedIndex, // Index de l'onglet actuellement actif.
        selectedItemColor: kPrimaryColor, // Couleur de l'icône et du libellé de l'onglet sélectionné.
        unselectedItemColor: Colors.grey, // Couleur pour les onglets non sélectionnés.
        onTap: _onItemTapped, // Fonction à appeler lors du clic sur un onglet.
        type: BottomNavigationBarType.fixed, // Assure que tous les libellés sont visibles et que la taille est fixe.
        showUnselectedLabels: true, // Afficher les libellés même pour les onglets non sélectionnés.
      ),
    );
  }
}
