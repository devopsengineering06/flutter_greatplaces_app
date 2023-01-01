import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

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
    DBHelper.insert('user_places', {
      'id': newPlace.id as String,
      'title': newPlace.title as String,
      'image': newPlace.image?.path as String,
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
            location: null,
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
