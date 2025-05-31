import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Importation du package shimmer pour l'effet de chargement.
import '../utils/fade_page_route.dart'; // Pour la navigation avec transition en fondu.
import 'map_display_page.dart'; // Page pour afficher la carte du lieu sélectionné.
import '../services/api_service.dart'; // Service pour interagir avec l'API Django.
import '../models/place.dart'; // Modèle de données pour un lieu.
import '../models/user_preferences.dart'; // Modèle de données pour les préférences utilisateur.

// StatefulWidget qui affiche les lieux suggérés en fonction des préférences de l'utilisateur.
// Il gère l'état de chargement des données depuis l'API, les erreurs éventuelles,
// et l'affichage de la liste des lieux ou d'un effet "shimmer" pendant le chargement.
class SuggestedPlacesPage extends StatefulWidget {
  // Préférences de l'utilisateur reçues de la page précédente.
  final UserPreferences userPreferences;

  const SuggestedPlacesPage({super.key, required this.userPreferences});

  @override
  State<SuggestedPlacesPage> createState() => _SuggestedPlacesPageState();
}

class _SuggestedPlacesPageState extends State<SuggestedPlacesPage> {
  // Instance du service API pour effectuer les appels réseau.
  final ApiService _apiService = ApiService();

  // Liste des lieux qui seront affichés. Initialement vide.
  List<Place> _places = [];
  // Chaîne pour stocker un message d'erreur en cas de problème lors de l'appel API.
  String _errorMessage = '';
  // Booléen pour indiquer si les données sont en cours de chargement.
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Lance la récupération des lieux dès l'initialisation de la page.
    _fetchSuggestedPlaces();
  }

  // Méthode asynchrone pour récupérer les lieux suggérés depuis l'ApiService.
  Future<void> _fetchSuggestedPlaces() async {
    // Met à jour l'état pour indiquer le début du chargement et réinitialiser les erreurs.
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // Optionnel: Simuler un délai pour mieux visualiser l'effet shimmer pendant le développement.
      // await Future.delayed(const Duration(seconds: 3));

      // Appel effectif au service API pour obtenir les lieux.
      _places = await _apiService.getSuggestedPlaces(widget.userPreferences);
    } catch (e) {
      // En cas d'erreur (exception levée par ApiService), stocke le message d'erreur.
      // Nettoyage simple du message pour l'affichage.
      _errorMessage = e.toString().replaceFirst('Exception: ', '').replaceFirst('Exception: ', '');
    } finally {
      // S'assure que le widget est toujours monté (dans l'arbre des widgets) avant d'appeler setState.
      // Ceci évite les erreurs si l'utilisateur quitte la page avant la fin de l'appel API.
      if (mounted) {
        setState(() {
          _isLoading = false; // Termine l'état de chargement.
        });
      }
    }
  }

  // Construit l'interface utilisateur principale de la page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lieux Suggérés'), // Titre de la page.
      ),
      body: _buildBody(), // Le corps est délégué à une méthode séparée pour la clarté.
    );
  }

  // Méthode privée pour construire un élément de la liste placeholder (squelette).
  // Utilisé par l'effet Shimmer pour simuler l'apparence des éléments de la liste pendant le chargement.
  Widget _buildPlaceholderListItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espacement standard.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alignement des enfants au début de l'axe transversal.
        children: <Widget>[
          // Placeholder rectangulaire pour l'image du lieu.
          Container(
            width: 60.0, // Largeur fixe.
            height: 60.0, // Hauteur fixe.
            color: Colors.white, // La couleur réelle n'importe pas, car Shimmer la recouvre.
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0), // Espace entre l'image et le texte.
          ),
          // Espace flexible pour les placeholders de texte, qui s'étend pour remplir la largeur restante.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alignement du texte à gauche.
              children: <Widget>[
                // Placeholder pour la première ligne de texte (ex: nom du lieu).
                Container(
                  width: double.infinity, // Prend toute la largeur disponible.
                  height: 12.0, // Hauteur d'une ligne de texte.
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0), // Espace vertical entre les lignes.
                ),
                // Placeholder pour la deuxième ligne de texte (ex: catégorie).
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                ),
                 const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                // Placeholder pour une troisième ligne de texte (plus courte).
                Container(
                  width: MediaQuery.of(context).size.width * 0.5, // Prend 50% de la largeur de l'écran.
                  height: 10.0,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Construit le corps de la page en fonction de l'état actuel (chargement, erreur, données disponibles).
  Widget _buildBody() {
    if (_isLoading) {
      // Si les données sont en cours de chargement, affiche l'effet Shimmer.
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Couleur de base pour l'animation Shimmer.
        highlightColor: Colors.grey[100]!, // Couleur de surbrillance pour l'animation Shimmer.
        enabled: _isLoading, // Active l'animation Shimmer.
        child: ListView.builder(
          itemCount: 6, // Nombre de placeholders à afficher dans la liste.
          itemBuilder: (context, index) => _buildPlaceholderListItem(), // Construit chaque placeholder.
        ),
      );
    }
    if (_errorMessage.isNotEmpty) {
      // Si un message d'erreur est présent, l'affiche.
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Erreur: $_errorMessage\nVeuillez vérifier votre connexion ou réessayer plus tard.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }
    if (_places.isEmpty) {
      // Si la liste des lieux est vide (et pas en chargement, sans erreur), affiche un message.
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Aucun lieu trouvé pour les préférences sélectionnées.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    // Si les données sont chargées et qu'il n'y a pas d'erreur, affiche la liste des lieux.
    return ListView.builder(
      itemCount: _places.length, // Nombre d'éléments dans la liste.
      itemBuilder: (context, index) {
        final place = _places[index]; // Récupère le lieu à l'index actuel.
        return InkWell( // Rend l'élément de liste cliquable.
          onTap: () {
            // Action lors du clic: Navigue vers la page de la carte pour ce lieu.
            Navigator.of(context).push(
              FadePageRoute(
                child: MapDisplayPage(placeData: place.toMap()), // Passe les données du lieu.
              ),
            );
          },
          child: ListTile(
            title: Text(place.name), // Affiche le nom du lieu.
            subtitle: Text(place.category), // Affiche la catégorie du lieu.
            // Affiche l'image du lieu si une URL est fournie, sinon un placeholder.
            leading: (place.imageUrl.isNotEmpty)
                ? Image.network( // Widget pour afficher une image depuis une URL.
                    place.imageUrl,
                    width: 60, // Largeur de l'image (correspond au placeholder).
                    height: 60, // Hauteur de l'image.
                    fit: BoxFit.cover, // Assure que l'image couvre l'espace alloué.
                    // `errorBuilder` est appelé si l'image ne peut pas être chargée.
                    errorBuilder: (context, error, stackTrace) {
                      return Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.broken_image, color: Colors.grey, size: 30,));
                    },
                    // `loadingBuilder` affiche un widget pendant le chargement de l'image.
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child; // Si chargé, affiche l'image.
                      // Sinon, affiche un indicateur de progression.
                      return Container(width: 60, height: 60, color: Colors.grey[300], child: const Center(child: CircularProgressIndicator()));
                    },
                  )
                // Placeholder si `imageUrl` est vide.
                : Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 30,)),
          ),
        );
      },
    );
  }
}
