import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/fade_page_route.dart';
import 'suggested_places_page.dart';
import '../models/user_preferences.dart'; // Importation du modèle UserPreferences.

// StatefulWidget pour la page de sélection des préférences d'itinéraire.
// L'utilisateur peut ici choisir ses centres d'intérêt.
class ItineraryPreferencesPage extends StatefulWidget {
  const ItineraryPreferencesPage({super.key});

  @override
  State<ItineraryPreferencesPage> createState() =>
      _ItineraryPreferencesPageState();
}

class _ItineraryPreferencesPageState extends State<ItineraryPreferencesPage> {
  // Map pour stocker l'état de sélection de chaque préférence.
  // La clé est le nom de la préférence (String), la valeur est un booléen (true si sélectionné).
  final Map<String, bool> _preferences = {
    "Nature & paysages": false,
    "Histoire & culture": false,
    "Patrimoine local": false,
    "Tourisme moderne": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vos Préférences d'Itinéraire"),
        actions: [ // Conservation de l'icône des paramètres pour l'instant, comme dans la structure précédente.
          IconButton(
            icon: const Icon(CupertinoIcons.settings),
            tooltip: 'Ouvrir les paramètres', // Info-bulle en français.
            onPressed: () {
              // Action pour le bouton des paramètres.
              print('Bouton des paramètres cliqué'); // Message de débogage en français.
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0), // Espacement intérieur pour la liste.
        children: <Widget>[
          // Génération dynamique des CheckboxListTile pour chaque préférence.
          ..._preferences.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key), // Le nom de la préférence.
              value: _preferences[key], // L'état actuel de la sélection (coché/décoché).
              onChanged: (bool? value) {
                // Mise à jour de l'état lorsque l'utilisateur coche/décoche la case.
                setState(() {
                  _preferences[key] = value!;
                });
              },
            );
          }).toList(), // Conversion de l'iterable en liste de widgets.
          const SizedBox(height: 20), // Espace vertical avant le bouton.
          ElevatedButton(
            onPressed: () {
              // Action lors du clic sur le bouton "Voir les suggestions".
              // print('Préférences sélectionnées : $_preferences'); // Message de débogage pour voir les préférences.
              // Création d'un objet UserPreferences avec les sélections actuelles.
              final userPrefs = UserPreferences(preferences: _preferences);
              // Navigation vers la page des lieux suggérés, en passant l'objet UserPreferences.
              Navigator.of(context).push(
                FadePageRoute(
                  child: SuggestedPlacesPage(userPreferences: userPrefs),
                ),
              );
            },
            child: const Text('Voir les suggestions'),
          ),
        ],
      ),
    );
  }
}
