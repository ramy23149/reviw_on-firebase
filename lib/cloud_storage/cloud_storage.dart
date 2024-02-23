import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorage extends StatefulWidget {
  const CloudStorage({super.key});

  @override
  State<CloudStorage> createState() => _CloudStorageState();
}

class _CloudStorageState extends State<CloudStorage> {
  File? file;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    file = File(photo!.path);
    if (photo != null) {
      setState(() {
        file = File(photo.path);
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image picker'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                pickImage();
              },
              child: Text(
                'open the camera',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
             if (file != null)
              Image.memory(
                file!.readAsBytesSync(),
                height: 100,
                width: 100,
              ),
    
          ],
        ),
      ),
    );
  }
}


