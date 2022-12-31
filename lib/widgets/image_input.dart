import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │           Using Image Picker & The Device Camera                         │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199930#overview
   https://github.com/devopsengineering06/flutter_greatplaces_app/commit/9485aab1fd90ca8ccf0c14d48ce07aed1060325f
*/

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    // print(imageFile);

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │        Storing the Image on the Filesystem (on the Device)               │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199936#questions/15918466
   
*/
    setState(() {
      _storedImage = File(imageFile!.path);
    });

    final appdir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFile!.path);
    final savedImage =
        await File(imageFile.path).copy('${appdir.path}/$filename');

    print(appdir);
    print(filename);
    print(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
