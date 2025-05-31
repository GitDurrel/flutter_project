import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/fade_page_route.dart'; // Import for custom transition
import 'suggested_places_page.dart'; // Import for navigation target

class ItineraryPreferencesPage extends StatefulWidget {
  const ItineraryPreferencesPage({super.key});

  @override
  State<ItineraryPreferencesPage> createState() =>
      _ItineraryPreferencesPageState();
}

class _ItineraryPreferencesPageState extends State<ItineraryPreferencesPage> {
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
        actions: [ // Keeping settings icon for now as per previous structure
          IconButton(
            icon: const Icon(CupertinoIcons.settings),
            tooltip: 'Open Settings',
            onPressed: () {
              print('Settings button pressed');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ..._preferences.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: _preferences[key],
              onChanged: (bool? value) {
                setState(() {
                  _preferences[key] = value!;
                });
              },
            );
          }).toList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // print('Selected preferences: $_preferences'); // Can keep for debugging
              Navigator.of(context).push(
                FadePageRoute(
                  child: SuggestedPlacesPage(selectedPreferences: _preferences),
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
