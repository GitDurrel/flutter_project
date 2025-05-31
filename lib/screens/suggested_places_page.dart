import 'package:flutter/material.dart';
import '../utils/fade_page_route.dart'; // For navigation
import 'map_display_page.dart'; // For navigation

class SuggestedPlacesPage extends StatelessWidget {
  final Map<String, bool> selectedPreferences;

  const SuggestedPlacesPage({super.key, required this.selectedPreferences});

  // Mock data for places - now List<Map<String, dynamic>> to include double for lat/lng
  static final List<Map<String, dynamic>> _allMockPlaces = [
    {'name': 'Musée du Louvre', 'category': 'Histoire & culture', 'details': 'Famous art museum', 'latitude': 48.8606, 'longitude': 2.3376},
    {'name': 'Jardin des Tuileries', 'category': 'Nature & paysages', 'details': 'Historic public garden', 'latitude': 48.8636, 'longitude': 2.3279},
    {'name': 'Château de Versailles', 'category': 'Histoire & culture', 'details': 'Royal château', 'latitude': 48.8049, 'longitude': 2.1204},
    {'name': 'Tour Eiffel', 'category': 'Tourisme moderne', 'details': 'Iconic iron tower', 'latitude': 48.8584, 'longitude': 2.2945},
    {'name': 'Montmartre', 'category': 'Patrimoine local', 'details': 'Historic hill with basilica', 'latitude': 48.8867, 'longitude': 2.3431},
    {'name': 'Cathédrale Notre-Dame', 'category': 'Histoire & culture', 'details': 'Medieval Catholic cathedral', 'latitude': 48.8530, 'longitude': 2.3499},
    {'name': 'Parc des Buttes-Chaumont', 'category': 'Nature & paysages', 'details': 'Public park with a lake', 'latitude': 48.8768, 'longitude': 2.3800},
    {'name': 'La Défense', 'category': 'Tourisme moderne', 'details': 'Major business district', 'latitude': 48.8915, 'longitude': 2.2400},
    {'name': 'Canal Saint-Martin', 'category': 'Patrimoine local', 'details': 'Picturesque canal', 'latitude': 48.8717, 'longitude': 2.3657},
    {'name': 'Forêt de Fontainebleau', 'category': 'Nature & paysages', 'details': 'Large forest area, great for hikes', 'latitude': 48.4041, 'longitude': 2.6969},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter places based on selected preferences
    final List<Map<String, dynamic>> suggestedPlaces = _allMockPlaces.where((place) {
      // If no preferences are selected, show all places (or a specific subset, adjust as needed)
      bool anyPreferenceSelected = selectedPreferences.values.any((isSelected) => isSelected);
      if (!anyPreferenceSelected) {
        return true; // Or return false to show nothing, or a specific default list
      }
      // Otherwise, show places that match any of the selected preferences
      return selectedPreferences[place['category']] ?? false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lieux Suggérés'),
      ),
      body: suggestedPlaces.isEmpty
          ? const Center(
              child: Text(
                'Aucun lieu ne correspond à vos préférences actuelles, ou veuillez sélectionner des préférences.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: suggestedPlaces.length,
              itemBuilder: (context, index) {
                final place = suggestedPlaces[index];
                return InkWell(
                  onTap: () {
                    // print('Tapped on: ${place['name']}');
                    Navigator.of(context).push(
                      FadePageRoute(
                        child: MapDisplayPage(placeData: place),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(place['name'] as String? ?? 'Unknown Place'),
                    subtitle: Text(place['category'] as String? ?? 'Unknown Category'),
                    // You could add more details here, e.g., place['details']
                  ),
                );
              },
            ),
    );
  }
}
