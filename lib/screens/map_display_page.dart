import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// StatefulWidget pour afficher une carte Google Maps centrée sur un lieu spécifique.
class MapDisplayPage extends StatefulWidget {
  // Données du lieu à afficher, incluant nom, latitude, longitude, etc.
  final Map<String, dynamic> placeData;

  const MapDisplayPage({super.key, required this.placeData});

  @override
  State<MapDisplayPage> createState() => _MapDisplayPageState();
}

class _MapDisplayPageState extends State<MapDisplayPage> {
  // Contrôleur pour interagir avec la GoogleMap.
  late GoogleMapController mapController;
  // Coordonnées LatLng du lieu.
  late LatLng _placeLatLng;
  // Ensemble des marqueurs à afficher sur la carte (ici, un seul marqueur pour le lieu).
  final Set<Marker> _markers = {};

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
      _placeLatLng = const LatLng(48.8566, 2.3522); // Position par défaut (centre de Paris).
    } else {
      _placeLatLng = LatLng(lat, lng);
    }

    // Ajout du marqueur pour le lieu sur la carte.
    _markers.add(
      Marker(
        // Identifiant unique pour le marqueur. Utilisation du nom du lieu.
        markerId: MarkerId(widget.placeData['name'] as String? ?? 'Lieu inconnu'),
        // Position du marqueur.
        position: _placeLatLng,
        // Fenêtre d'information affichée lors du clic sur le marqueur.
        infoWindow: InfoWindow(
          title: widget.placeData['name'] as String? ?? 'Lieu inconnu', // Nom du lieu.
          snippet: widget.placeData['category'] as String? ?? '', // Catégorie du lieu comme sous-titre.
        ),
      ),
    );
  }

  // Callback appelé lors de la création de la carte.
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // On pourrait ici, par exemple, animer la caméra vers la position si nécessaire.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Titre de l'AppBar : nom du lieu.
        title: Text(widget.placeData['name'] as String? ?? 'Carte'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated, // Callback pour la création de la carte.
        // Position initiale de la caméra centrée sur le lieu.
        initialCameraPosition: CameraPosition(
          target: _placeLatLng, // Cible : coordonnées du lieu.
          zoom: 14.0, // Niveau de zoom initial.
        ),
        markers: _markers, // Ensemble des marqueurs à afficher.
        compassEnabled: true, // Afficher la boussole sur la carte.
        zoomGesturesEnabled: true, // Activer les gestes de zoom.
        // On pourrait ajouter d'autres options : myLocationEnabled, mapType, etc.
      ),
    );
  }
}
