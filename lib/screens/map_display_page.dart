import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDisplayPage extends StatefulWidget {
  final Map<String, dynamic> placeData;

  const MapDisplayPage({super.key, required this.placeData});

  @override
  State<MapDisplayPage> createState() => _MapDisplayPageState();
}

class _MapDisplayPageState extends State<MapDisplayPage> {
  late GoogleMapController mapController;
  late LatLng _placeLatLng;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Ensure latitude and longitude are parsed as doubles
    final lat = widget.placeData['latitude'];
    final lng = widget.placeData['longitude'];

    if (lat is! double || lng is! double) {
      // Handle error or set default if types are incorrect
      // For now, printing an error and using a default location
      print("Error: Latitude or Longitude is not a double. Received lat: $lat, lng: $lng");
      _placeLatLng = const LatLng(48.8566, 2.3522); // Default to Paris center
    } else {
      _placeLatLng = LatLng(lat, lng);
    }

    _markers.add(
      Marker(
        markerId: MarkerId(widget.placeData['name'] as String? ?? 'Unknown Place'),
        position: _placeLatLng,
        infoWindow: InfoWindow(
          title: widget.placeData['name'] as String? ?? 'Unknown Place',
          snippet: widget.placeData['category'] as String? ?? '',
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeData['name'] as String? ?? 'Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _placeLatLng,
          zoom: 14.0,
        ),
        markers: _markers,
        compassEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }
}
