import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pick_image/utilities/global.dart';
import 'package:flutter_pick_image/widgets/disply_image.dart';
import 'package:image_cropper/image_cropper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? finalImageFile;

  // pick image from gallery or camera
  void selectImage({required bool fromCamera}) async {
    final pickedImage = await pickImage(fromCamera: fromCamera);
    if (pickedImage != null) {
      // crop image
      await cropImage(pickedImage.path);

      popContext();
    }
  }

  popContext() {
    Navigator.pop(context);
  }

  Future<void> cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    );

    if (croppedFile != null) {
      finalImageFile = File(croppedFile.path);
      setState(() {});
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                selectImage(fromCamera: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                selectImage(fromCamera: false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: DisplayImage(
            file: finalImageFile,
            onPressed: () {
              // show bottom sheet
              showBottomSheet();
            }),
      ),
    );
  }
}
