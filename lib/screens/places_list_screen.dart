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
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: const Center(
                    child: Text('Start adding some'),
                  ),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                      ? ch! // include ! for null safety to make sure that you telling dart it will not be a null
                      : ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                  greatPlaces.items[i].image as File,
                                  scale: 1),
                            ),
                            title: Text(greatPlaces.items[i].title as String),
                            subtitle: Text(greatPlaces
                                .items[i].location!.address as String),
                            onTap: () {},
                          ),
                        ),
                ),
        ));
  }
}
