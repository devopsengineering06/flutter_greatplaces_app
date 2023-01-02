import 'dart:convert';

import 'package:http/http.dart' as http;

const googleApiKey = '';

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │                   Displaying a Static Map Snapshot                       │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199984#overview
   https://github.com/devopsengineering06/flutter_greatplaces_app/commit/11912bc91f09c7b7a23601d55b8b3439a6fcf3b2
*/

class LocationHelper {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  /* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │                     Storing the Location in SQLite                       │
  └──────────────────────────────────────────────────────────────────────────┘
  https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15200000#questions/18305654
   
*/

  static Future<String> getPlaceAddress(double? lat, double? lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
