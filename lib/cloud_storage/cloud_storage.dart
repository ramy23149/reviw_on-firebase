import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudStorage extends StatefulWidget {
  const CloudStorage({Key? key}) : super(key: key);

  @override
  State<CloudStorage> createState() => _CloudStorageState();
}

class _CloudStorageState extends State<CloudStorage> {
  html.File? file;
  String? imageUrl;

  Future<void> pickImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        setState(() {
          file = input.files![0];
        });

        // Now that file is set, you can upload it to Firebase Storage
        uploadFileToFirebaseStorage();
      }
    });
  }

  Future<void> uploadFileToFirebaseStorage() async {
    if (file != null) {
      var fileName = '${DateTime.now().millisecondsSinceEpoch}_${file!.name}';
      var storageRef = FirebaseStorage.instance.ref(fileName);
      var uploadTask = storageRef.putBlob(file!);
      var snapshot = await uploadTask;
      
      // Get the download URL from the storage reference
      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });

      // Debugging: Print imageUrl to check its value
      print('Download URL: $imageUrl');
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
                'Open the gallery',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                height: 100,
                width: 100,
              ),
            if (imageUrl == null && file != null) Text('Uploading...'),
          ],
        ),
      ),
    );
  }
}
