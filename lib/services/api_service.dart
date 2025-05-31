// Fichier: lib/services/api_service.dart
import 'dart:convert'; // Pour jsonDecode et utf8.decode
import 'package:http/http.dart' as http; // Pour effectuer des requêtes HTTP
import '../models/place.dart'; // Modèle de données pour un lieu
import '../models/user_preferences.dart'; // Modèle de données pour les préférences utilisateur

// Classe responsable de la communication avec l'API Django.
class ApiService {
  // URL de base de l'API Django.
  // IMPORTANT: REMPLACEZ 'https://votre-api-django.com/api' PAR VOTRE VRAIE URL D'API.
  final String _baseUrl = 'https://votre-api-django.com/api'; // TODO: À REMPLACER

  // Récupère la liste des lieux suggérés depuis l'API en fonction des préférences de l'utilisateur.
  Future<List<Place>> getSuggestedPlaces(UserPreferences userPreferences) async {
    // Construit la chaîne de paramètres de requête à partir des préférences.
    final queryParams = userPreferences.toQueryParameters();

    // TODO: Ajuster le chemin exact de l'endpoint si celui-ci est différent.
    // Exemple d'URI: https://votre-api-django.com/api/places/suggestions/?nature_&_paysages=true&histoire_&_culture=true
    final Uri uri = Uri.parse('$_baseUrl/places/suggestions/?$queryParams');

    try {
      // Optionnel: Simuler un délai réseau pour tester l'affichage de chargement.
      // await Future.delayed(const Duration(seconds: 2));

      // Effectue la requête GET à l'API.
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // Ajoutez ici d'autres en-têtes si votre API les requiert (ex: jeton d'authentification).
        // 'Authorization': 'Bearer VOTRE_JETON_API',
      });

      // Vérifie si la requête a réussi (code de statut HTTP 200 OK).
      if (response.statusCode == 200) {
        // Décode le corps de la réponse (qui est en UTF-8) en une liste dynamique.
        // response.bodyBytes est utilisé pour garantir une gestion correcte des caractères spéciaux (ex: accents).
        List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        // Convertit chaque élément de la liste dynamique en un objet Place.
        List<Place> places = body.map((dynamic item) => Place.fromJson(item as Map<String, dynamic>)).toList();
        return places;
      } else {
        // Si le serveur retourne un code d'erreur (ex: 404 Non Trouvé, 500 Erreur Serveur).
        // TODO: Journaliser (log) le code de statut et le corps de la réponse pour le débogage.
        // print('Erreur API: ${response.statusCode} - ${response.body}');
        throw Exception('Impossible de charger les lieux suggérés (Code: ${response.statusCode})');
      }
    } catch (e) {
      // Gère les erreurs qui peuvent survenir lors de la requête réseau (ex: pas de connexion)
      // ou lors du parsing des données JSON.
      // TODO: Journaliser (log) l'erreur détaillée.
      // print('Erreur ApiService: $e');
      throw Exception('Erreur de connexion ou de traitement des données: $e');
    }
  }
}
