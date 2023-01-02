import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │               Rendering a Dynamic Map (via Google Maps)                  │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199988#overview
   
*/


class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {super.key,
      this.initialLocation =const PlaceLocation(
        latitude: 39.9334,
        longitude: 32.8597,
      ),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude as double,
            widget.initialLocation.longitude as double,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
