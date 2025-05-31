import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2; // Aliased for clarity

// StatefulWidget pour afficher une carte OpenStreetMap centrée sur un lieu spécifique.
class MapDisplayPage extends StatefulWidget {
  // Données du lieu à afficher, incluant nom, latitude, longitude, etc.
  final Map<String, dynamic> placeData;

  const MapDisplayPage({super.key, required this.placeData});

  @override
  State<MapDisplayPage> createState() => _MapDisplayPageState();
}

class _MapDisplayPageState extends State<MapDisplayPage> {
  // Coordonnées LatLng du lieu pour flutter_map.
  late latlong2.LatLng _placeLatLng;
  // Liste des marqueurs à afficher sur la carte.
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    // S'assurer que la latitude et la longitude sont correctement interprétées comme des doubles.
    final lat = widget.placeData['latitude'];
    final lng = widget.placeData['longitude'];

    if (lat is! double || lng is! double) {
      // Gérer l'erreur ou définir une valeur par défaut si les types sont incorrects.
      // Pour l'instant, affichage d'une erreur et utilisation d'une position par défaut (Paris).
      print("Erreur : La latitude ou la longitude n'est pas un double. Reçu lat: $lat, lng: $lng");
      _placeLatLng = latlong2.LatLng(48.8566, 2.3522); // Position par défaut (centre de Paris).
    } else {
      _placeLatLng = latlong2.LatLng(lat, lng);
    }

    // Ajout du marqueur pour le lieu sur la carte.
    // Note: flutter_map Markers are different from google_maps_flutter Markers.
    // They are simpler and typically just a point with a widget (child).
    // InfoWindow functionality needs custom implementation if desired.
    _markers.add(
      Marker(
        point: _placeLatLng,
        width: 80.0, // Largeur du marqueur
        height: 80.0, // Hauteur du marqueur
        child: Tooltip( // Utilisation d'un Tooltip en guise d'info simple au survol (sur web/desktop) ou appui long (mobile)
          message: '${widget.placeData['name'] as String? ?? 'Lieu inconnu'}\n${widget.placeData['category'] as String? ?? ''}',
          child: const Icon(
            Icons.location_pin,
            size: 50,
            color: Colors.red,
          ),
        )
      ),
    );
  }

  // Pas de _onMapCreated nécessaire pour flutter_map dans cette configuration simple.
  // Le MapController peut être utilisé pour des interactions programmatiques si besoin.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Titre de l'AppBar : nom du lieu.
        title: Text(widget.placeData['name'] as String? ?? 'Carte'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _placeLatLng, // Cible : coordonnées du lieu.
          initialZoom: 14.0, // Niveau de zoom initial.
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.tourcam_360', // TODO: Remplacer par le vrai nom du package de l'app
                                                        // Utiliser un nom de package pertinent pour l'application.
          ),
          MarkerLayer(
            markers: _markers, // Liste des marqueurs à afficher.
          ),
        ],
      ),
    );
  }
}
