import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, required this.categoryName, required this.docId});
  final String categoryName;
  final String docId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'warning',
          desc: 'are you sure to delete this note?',
          btnOkOnPress: () async {
            await FirebaseFirestore.instance
                .collection('categoris')
                .doc(docId)
                .delete();
            Navigator.of(context).pushReplacementNamed('HomePage');
          },
          btnCancelOnPress: () {},
        ).show();
      },
      child: Card(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                  'https://cdn1.iconfinder.com/data/icons/document-management-2/64/Floder-document-managment-data-office-64.png'),
            ),
            // SizedBox(height: 20,),
            Text(
              categoryName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
