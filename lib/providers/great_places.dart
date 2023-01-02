import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                                 Properties                                  │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  List<Place> _items = [];

  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                                 Getters                                     │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  List<Place> get items {
    return [..._items];
  }

  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                                Find By Id                                   │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                                Add Method                                   │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude!, pickedLocation.longitude!);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );

    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
          .substring(appDir.path.length, newPlace.image.path.length),
      'loc_lat': newPlace.location!.latitude!,
      'loc_lng': newPlace.location!.longitude!,
      'address': newPlace.location!.address!,
    });
  }

  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                         Fetch And Set Method                                │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
            image: File('${appDir.path}/${item['image']}'),
          ),
        )
        .toList();

    notifyListeners();
  }
}
