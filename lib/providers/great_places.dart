import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  /* 
  ┌─────────────────────────────────────────────────────────────────────────────┐
  │                                 Properties                                  │
  └─────────────────────────────────────────────────────────────────────────────┘
 */

  final List<Place> _items = [];

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

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
