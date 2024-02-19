// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_app/components/Custom_card.dart';
import 'package:market_app/note/add.dart';
import 'package:market_app/note/edit.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key, required this.docId});
  final String docId;
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true;

  @override
  void initState() {
    getData();

    super.initState();
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categoris')
        .doc(widget.docId)
        .collection('note')
        .get();
    setState(() {
      //data = querySnapshot.docs;
      data.addAll(querySnapshot.docs);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('notes'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('login');
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: WillPopScope(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      GridView.builder(
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                                mainAxisExtent: 155),
                        itemBuilder: (context, index) {
                          return CustomCard(
                              onLongPress: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: 'alert',
                                  desc: 'Are you sure to delete this note?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    FirebaseFirestore.instance
                                        .collection('categoris')
                                        .doc(widget.docId)
                                        .collection('note')
                                        .doc(data[index].id)
                                        .delete();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NoteView(docId: widget.docId)));
                                  },
                                )..show();
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditNote(
                                            categoryName: data[index]['note'],
                                            noteDocId: data[index].id,
                                            categoryDocId: widget.docId)));
                              },
                              docId: data[index].id,
                              categoryName: '${data[index]['note']}');
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: FloatingActionButton(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.cyan,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNote(
                                          docId: widget.docId,
                                        )));
                          },
                          child: const Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
            onWillPop: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'HomePage', (route) => false);
              return Future.value(false);
            }));
  }
}
