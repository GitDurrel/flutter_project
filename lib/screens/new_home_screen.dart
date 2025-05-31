import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/fade_page_route.dart'; // Pour la navigation avec transition en fondu
import 'map_display_page.dart'; // Pour afficher la carte du lieu sélectionné
// Importer les constantes si les couleurs de fond doivent être dynamiques basées sur kPrimaryColor etc.
// import '../utils/constants.dart'; // Décommenter si kPrimaryColor est utilisé pour le style du bouton par exemple.

// Écran d'accueil immersif avec un carrousel de lieux et un fond adaptatif (placeholder pour l'instant).
class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  // Index de l'élément (slide) actuellement affiché dans le carrousel.
  // Utilisé pour savoir quelle "page" du carrousel est active.
  int _currentCarouselIndex = 0;

  // Décoration pour le fond d'écran actuel.
  // Prévu pour être dynamiquement modifié (par exemple, en fonction de la météo ou de l'heure).
  // Initialisé avec un dégradé bleu par défaut.
  BoxDecoration _currentBackground = const BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.lightBlueAccent], // Couleurs du dégradé.
      begin: Alignment.topLeft, // Point de départ du dégradé.
      end: Alignment.bottomRight, // Point de fin du dégradé.
    ),
  );

  // Liste statique de données pour les lieux affichés dans le carrousel.
  // C'est un sous-ensemble des lieux disponibles, spécifiquement pour cet écran d'accueil.
  // Chaque lieu est une Map contenant: nom, détails, latitude, longitude, et une couleur pour le placeholder d'image.
  static final List<Map<String, dynamic>> _carouselLocations = [
    {
      'name': 'Chutes de la Métché',
      'details': 'Impressionnantes chutes d\'eau près de Dschang.',
      'latitude': 5.4500, 'longitude': 10.0500,
      'placeholderColor': Colors.teal, // Couleur utilisée pour le fond du placeholder d'image.
    },
    {
      'name': 'Musée des Civilisations à Dschang',
      'details': 'Explore l\'histoire et la culture des peuples de l\'Ouest Cameroun.',
      'latitude': 5.4430, 'longitude': 10.0600,
      'placeholderColor': Colors.amber,
    },
    {
      'name': 'Chefferie de Bafoussam',
      'details': 'Siège traditionnel important, riche en histoire et culture Bamileke.',
      'latitude': 5.4730, 'longitude': 10.4200,
      'placeholderColor': Colors.purple,
    },
    {
      'name': 'Mont Mbapit',
      'details': 'Volcan éteint avec un lac de cratère, offre des vues panoramiques.',
      'latitude': 5.1500, 'longitude': 10.7000,
      'placeholderColor': Colors.green,
    },
    {
      'name': 'Lac Baleng',
      'details': 'Lac de cratère mystique, lieu de légendes locales.',
      'latitude': 5.4800, 'longitude': 10.3500,
      'placeholderColor': Colors.cyan,
    }
  ];

  // TODO: Implémenter une fonction pour mettre à jour `_currentBackground`.
  // Cette fonction pourrait être appelée lors du changement de slide du carrousel (`onPageChanged`)
  // ou en réponse à des données météorologiques (fonctionnalité future).
  // void _updateBackground(int index) {
  //   // Exemple : Changer la couleur de fond en fonction de l'index du carrousel.
  //   setState(() {
  //     // Utilisation d'une liste de couleurs d'accentuation pour varier les fonds.
  //     _currentBackground = BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Colors.accents[index % Colors.accents.length], Colors.white],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //     );
  //   });
  // }

  // Construction de l'interface utilisateur du widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // L'AppBar peut être omise ou rendue transparente pour un effet plus immersif.
      // Si une AppBar est souhaitée, elle peut être définie ici ou héritée du MainScaffold.
      // appBar: AppBar(title: const Text("Accueil Immersif"), backgroundColor: Colors.transparent, elevation: 0),
      body: Stack( // Utilisation d'un Stack pour superposer le carrousel sur le fond d'écran.
        children: <Widget>[
          // Première couche du Stack : le fond d'écran.
          // AnimatedContainer permet une transition en douceur si _currentBackground change.
          AnimatedContainer(
            duration: const Duration(seconds: 1), // Durée de l'animation pour le changement de fond.
            decoration: _currentBackground, // Applique la décoration de fond actuelle.
          ),
          // Deuxième couche du Stack : le carrousel.
          // Center est utilisé ici pour centrer le carrousel dans l'espace disponible,
          // bien que la hauteur du CarouselOptions définisse sa taille principale.
          Center(
            child: CarouselSlider.builder(
              itemCount: _carouselLocations.length, // Nombre total d'éléments dans le carrousel.
              // `itemBuilder` est appelé pour construire chaque élément (slide) du carrousel.
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                final location = _carouselLocations[itemIndex]; // Données du lieu pour le slide actuel.
                // Chaque slide est une Card pour un effet d'élévation et des coins arrondis.
                return Card(
                  elevation: 5, // Ombre sous la carte.
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0), // Marges autour de la carte.
                  clipBehavior: Clip.antiAlias, // Assure que le contenu de la carte respecte les coins arrondis.
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), // Forme de la carte.
                  child: Stack( // Stack interne à la carte pour superposer du texte/bouton sur l'image placeholder.
                    alignment: Alignment.bottomCenter, // Aligne les enfants en bas au centre.
                    children: <Widget>[
                      // Placeholder pour l'image du lieu.
                      // Un Container coloré est utilisé car les images réelles ne sont pas gérées dans cette phase.
                      Container(
                        color: location['placeholderColor'] as Color? ?? Colors.blueGrey, // Couleur de fond du placeholder.
                        child: Center( // Centre le texte du placeholder.
                          child: Text(
                            "Image de ${location['name']}", // Texte indiquant le nom du lieu.
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Conteneur pour la superposition de texte et du bouton.
                      // Un dégradé est appliqué en bas pour améliorer la lisibilité du texte.
                      Container(
                        padding: const EdgeInsets.all(10.0), // Espacement interne.
                        decoration: BoxDecoration(
                          gradient: LinearGradient( // Dégradé du noir (avec opacité) vers transparent.
                            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Column( // Organisation verticale du nom, des détails et du bouton.
                          mainAxisSize: MainAxisSize.min, // La colonne prend la hauteur minimale nécessaire.
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Les enfants s'étirent pour remplir la largeur.
                          children: <Widget>[
                            Text( // Nom du lieu.
                              location['name'] as String,
                              style: const TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5.0), // Espace vertical.
                            Text( // Détails du lieu.
                              location['details'] as String,
                              style: const TextStyle(color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.center,
                              maxLines: 2, // Limite le texte à 2 lignes.
                              overflow: TextOverflow.ellipsis, // Ajoute "..." si le texte dépasse.
                            ),
                            const SizedBox(height: 10.0), // Espace vertical.
                            ElevatedButton( // Bouton "En savoir plus".
                              style: ElevatedButton.styleFrom(
                                // Pour utiliser les couleurs du thème global :
                                // backgroundColor: Theme.of(context).primaryColor, // ou kPrimaryColor si importé
                                // foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                // Action de navigation vers la page de la carte.
                                // Les données complètes du lieu sont passées à MapDisplayPage.
                                Navigator.of(context).push(
                                  FadePageRoute( // Utilisation de la transition en fondu.
                                    child: MapDisplayPage(placeData: location),
                                  ),
                                );
                              },
                              child: const Text("En savoir plus"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              // Options de configuration pour le CarouselSlider.
              options: CarouselOptions(
                height: 450.0, // Hauteur fixe pour chaque élément du carrousel.
                autoPlay: true, // Active le défilement automatique.
                autoPlayInterval: const Duration(seconds: 5), // Durée entre chaque défilement automatique.
                enlargeCenterPage: true, // L'élément central apparaît plus grand que les autres.
                aspectRatio: 16 / 9, // Ratio d'aspect des éléments.
                viewportFraction: 0.8, // Pourcentage de la largeur de la fenêtre que chaque page du carrousel occupe.
                                      // Une valeur inférieure à 1.0 permet de voir des aperçus des slides adjacents.
                // `onPageChanged` est appelé lorsque la page du carrousel change.
                onPageChanged: (index, reason) {
                  setState(() { // Met à jour l'état avec le nouvel index.
                    _currentCarouselIndex = index;
                    // Ici, on pourrait appeler `_updateBackground(index)` pour changer le fond
                    // en fonction du slide affiché, si cette fonctionnalité était implémentée.
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
