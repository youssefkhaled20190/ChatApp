import 'dart:io';
import 'package:chatapp/widgits/fonts/customtxt.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class pickImage extends StatefulWidget {
  final void Function(File pickedImage) pickimagefn;
  pickImage(this.pickimagefn);

  @override
  State<pickImage> createState() => _pickImageState();
}

class _pickImageState extends State<pickImage> {
  File? _pickedimage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource scr) async {
    final pickedImageFile =
        await _picker.pickImage(source: scr, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedimage = File(pickedImageFile.path);
      });
      widget.pickimagefn(_pickedimage!);
    } else {
      print("no image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedimage != null ? FileImage(_pickedimage!) : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.photo_camera_outlined,
                size: 40,
                color: Colors.black,
              ),
              label: Txt("Add Image \nFrom Camera", Colors.black, 15),
            ),
            TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.image_outlined,
                size: 40,
                color: Colors.black,
              ),
              label: Txt("Add Image \nFrom Galery", Colors.black, 15),
            ),
          ],
        )
      ],
    );
  }
}
