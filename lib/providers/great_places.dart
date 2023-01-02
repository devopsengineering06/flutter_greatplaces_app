import 'dart:io';

import 'package:flutter/foundation.dart';

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
  │                                Add Method                                   │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude as double,
      longitude: pickedLocation.longitude as double,
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
      'id': newPlace.id as String,
      'title': newPlace.title as String,
      'image': newPlace.image?.path as String,
      'loc_lat': newPlace.location!.latitude as double,
      'loc_lng': newPlace.location!.longitude as double,
      'address': newPlace.location!.address as String,
    });
  }

  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                         Fetch And Set Method                                │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
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
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
