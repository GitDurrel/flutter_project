// Fichier: lib/services/api_service.dart
import 'dart:convert'; // Pour jsonDecode et utf8.decode
import 'package:flutter/services.dart' show rootBundle; // Pour charger les assets locaux
import 'package:http/http.dart' as http; // Pour effectuer des requêtes HTTP
import '../models/place.dart'; // Modèle de données pour un lieu
import '../models/user_preferences.dart'; // Modèle de données pour les préférences utilisateur

// Classe responsable de la communication avec l'API Django.
class ApiService {
  // URL de base de l'API Django.
  // IMPORTANT: REMPLACEZ 'https://votre-api-django.com/api' PAR VOTRE VRAIE URL D'API.
  final String _baseUrl = 'https://votre-api-django.com/api'; // TODO: À REMPLACER

  // Récupère la liste des lieux suggérés depuis le fichier JSON local.
  Future<List<Place>> getSuggestedPlaces(UserPreferences userPreferences) async {
    // userPreferences est conservé pour une potentielle utilisation future (filtrage local).
    try {
      // Optionnel: Simuler un délai pour tester l'affichage de chargement.
      // await Future.delayed(const Duration(seconds: 1));

      // Charge le contenu du fichier JSON depuis les assets.
      final String jsonString = await rootBundle.loadString('assets/static_data/suggested_places.json');

      // Décode la chaîne JSON en une liste dynamique.
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

      // Convertit chaque élément de la liste dynamique en un objet Place.
      final List<Place> places = jsonList
          .map((dynamic item) => Place.fromJson(item as Map<String, dynamic>))
          .toList();

      return places;
    } catch (e) {
      // Gère les erreurs qui peuvent survenir lors du chargement du fichier
      // ou lors du parsing des données JSON.
      // TODO: Journaliser (log) l'erreur détaillée.
      // print('Erreur ApiService (getSuggestedPlaces): $e');
      throw Exception('Impossible de charger les lieux suggérés depuis les données locales: $e');
    }
  }
}
