import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │            Adding the "Add Place" Screen & An Image Input                │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199926#overview
   
*/

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = 'add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a New Place',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.add,
            ),
            label: const Text(
              'Add Place',
            ),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
