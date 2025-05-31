// Fichier: lib/models/place.dart
// ignore_for_file: prefer_initializing_formals // Pour la compatibilité avec des versions plus anciennes de Dart

class Place {
  final String name;
  final String description; // Sera 'details' dans toMap pour MapDisplayPage
  final String category;
  final double latitude;
  final double longitude;
  final String imageUrl;

  Place({
    required this.name,
    required this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
  });

  // Factory constructor pour créer une instance de Place à partir d'un JSON.
  // Gère les valeurs nulles ou manquantes avec des valeurs par défaut.
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String? ?? 'Nom inconnu',
      description: json['description'] as String? ?? 'Description inconnue',
      category: json['category'] as String? ?? 'Catégorie inconnue',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] as String? ?? '', // S'assurer que c'est bien 'image_url' et non 'imageUrl' dans le JSON
    );
  }

  // Méthode pour convertir un objet Place en Map<String, dynamic>.
  // Utile pour passer les données à MapDisplayPage, qui attend une Map.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': description, // 'details' est le nom de champ attendu par MapDisplayPage pour la description.
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl, // MapDisplayPage n'utilise pas activement imageUrl pour l'instant, mais inclus pour complétude.
    };
  }
}
