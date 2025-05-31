// Fichier: lib/models/user_preferences.dart

// Classe pour encapsuler les préférences de l'utilisateur.
class UserPreferences {
  // Map stockant les préférences, où la clé est le nom de la préférence
  // et la valeur est un booléen indiquant si elle est sélectionnée.
  final Map<String, bool> preferences;

  UserPreferences({required this.preferences});

  // Méthode pour convertir les préférences en une chaîne de paramètres de requête URL.
  // Utilisée pour construire l'URL de l'appel API.
  String toQueryParameters() {
    // Si aucune préférence n'est définie, retourne une chaîne vide.
    if (preferences.isEmpty) return '';

    // Construit la chaîne de requête.
    // Exemple: "nature_&_paysages=true&histoire_&_culture=true"
    return preferences.entries
        .where((entry) => entry.value == true) // Inclut seulement les préférences sélectionnées (valeur true).
        .map((entry) => '${Uri.encodeComponent(entry.key.replaceAll(' ', '_').toLowerCase())}=true') // Formate chaque préférence.
        .join('&'); // Joint les paramètres avec '&'.
  }
}
