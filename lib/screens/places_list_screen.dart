import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: const Center(
            child: Text('Start adding some'),
          ),
          builder: (ctx, greatPlace, ch) => greatPlace.items.isEmpty
              ? ch! // include ! for null safety to make sure that you telling dart it will not be a null
              : ListView.builder(
                  itemCount: greatPlace.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                          greatPlace.items[i].image as File,
                          scale: 1),
                    ),
                    title: Text(greatPlace.items[i].title as String),
                    onTap: () {},
                  ),
                ),
        ));
  }
}
