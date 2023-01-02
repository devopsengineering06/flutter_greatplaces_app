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
}
