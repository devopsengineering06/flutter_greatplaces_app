import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import './screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │                 PlaceList & Place Provider Setup                         │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199922#overview
   
*/

    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.indigo, secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
      ),
    );
  }
}
