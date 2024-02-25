import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pick_image/utilities/assets_manager.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({
    super.key,
    required this.file,
    required this.onPressed,
  });

  final File? file;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.deepPurple,
          backgroundImage: file == null
              ? const AssetImage(AssetsMenager.userIcon)
              : FileImage(File(file!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
