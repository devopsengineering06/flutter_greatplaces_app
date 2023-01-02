import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │               Rendering a Dynamic Map (via Google Maps)                  │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199988#overview
   https://github.com/devopsengineering06/flutter_greatplaces_app/commit/819a18bbe69f80074ad755d4cabbf9a86e1088b1
*/

class MapScreen extends StatefulWidget {
  final PlaceLocation? initialLocation;
  final bool isSelecting;

  const MapScreen(
      {super.key,
      this.initialLocation = const PlaceLocation(
        latitude: 39.9334,
        longitude: 32.8597,
      ),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │              Allowing Users to Pick a Location on the Map                │
  └──────────────────────────────────────────────────────────────────────────┘
  https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199996#questions/18305654
  https://github.com/devopsengineering06/flutter_greatplaces_app/commit/f9564e63a503f81201fcc532c63ecf9a5859e61d 
*/

  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation!.latitude!,
            widget.initialLocation!.longitude!,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation!.latitude!,
                        widget.initialLocation!.longitude!,
                      ),
                ),
              },
      ),
    );
  }
}
