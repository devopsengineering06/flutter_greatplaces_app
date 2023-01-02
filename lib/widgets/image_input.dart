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
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {super.key});

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
   https://github.com/devopsengineering06/flutter_greatplaces_app/commit/3a37d06db96ab620eff9113d6f151874240a55ef
*/

/* 
  ┌──────────────────────────────────────────────────────────────────────────┐
  │                              Handling Errors                             │
  └──────────────────────────────────────────────────────────────────────────┘
   https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15199956#questions/17730230
   https://github.com/devopsengineering06/flutter_greatplaces_app/commit/8c8681bcd5d0313238bd8932212d031a63186508
*/

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appdir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appdir.path}/$filename');
    await widget.onSelectImage(savedImage);
    // print(appdir);
    // print(filename);
    // print(savedImage);
  }

  Future<void> _pickPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage = await _storedImage!.copy('${appDir.path}/$fileName');
    await widget.onSelectImage(saveImage);
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
            onPressed: () {
              showBottomSheet(
                enableDrag: true,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            _takePicture.call();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('from camera'),
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _pickPicture.call();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.photo),
                          label: const Text('from gallery'),
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.image),
            label: const Text('add Image'),
            style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ),
      ],
    );
  }
}
