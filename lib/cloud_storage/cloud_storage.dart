import 'dart:html' as html;
import 'package:flutter/material.dart';

class CloudStorage extends StatefulWidget {
  const CloudStorage({Key? key}) : super(key: key);

  @override
  State<CloudStorage> createState() => _CloudStorageState();
}

class _CloudStorageState extends State<CloudStorage> {
  html.File? file;

  Future<void> pickImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        setState(() {
          file = input.files![0];
        });
      }
    });
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
            if (file != null)
              Image.network(
                html.Url.createObjectUrlFromBlob(file!),
                height: 100,
                width: 100,
              ),
          ],
        ),
      ),
    );
  }
}
