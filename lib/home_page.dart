// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_app/components/Custom_card.dart';
  import 'package:market_app/note/view.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
          automaticallyImplyLeading: false,
          title: const Text('HomePage'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('login');
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: isLoading
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteView(
                                      docId: data[index].id,
                                        )));
                          },
                          docId: data[index].id,
                          categoryName: '${data[index]['name']}');
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.cyan,
                      onPressed: () {
                        Navigator.of(context).pushNamed('AddCategoryPage');
                      },
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ));
  }
}
