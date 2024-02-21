import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/Filtering/user_info.dart';

class FilteringPage extends StatefulWidget {
  const FilteringPage({super.key});
  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  final Stream<QuerySnapshot> userCondation =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text('Filter'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          onPressed: () {
            CollectionReference users =
                FirebaseFirestore.instance.collection('users');
            WriteBatch batch = FirebaseFirestore.instance.batch();
            DocumentReference doc1 = users.doc('1');
            DocumentReference doc2 = users.doc('3');

            batch.delete(doc1);
            batch.set(doc2, {'name': 'shady', 'age': 15, 'money': 700});
            batch.commit();
          }),
      body: StreamBuilder<QuerySnapshot>(
          stream: userCondation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return UserInfo(
                    onTap: () {
                      DocumentReference documentReference = FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(snapshot.data!.docs[index].id);

                      FirebaseFirestore.instance
                          .runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(documentReference);

                        if (snapshot.exists) {
                          var snapShotData = snapshot.data();

                          if (snapShotData is Map<String, dynamic>) {
                            int money = snapShotData['money'] + 100;
                            transaction
                                .update(documentReference, {'money': money});
                          }
                        }
                      });
                    },
                    money: snapshot.data!.docs[index]['money'],
                    age: snapshot.data!.docs[index]['age'],
                    name: snapshot.data!.docs[index]['name'],
                  );
                });
          }),
    );
  }
}





// DocumentReference documentReference = FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(data[index].id);

//                 FirebaseFirestore.instance.runTransaction((transaction) async {
//                   DocumentSnapshot snapshot =
//                       await transaction.get(documentReference);

//                   if (snapshot.exists) {
//                     var snapShotData = snapshot.data();

//                     if (snapShotData is Map<String, dynamic>) {
//                       int money = snapShotData['money'] + 100;
//                       transaction.update(documentReference, {'money': money});
//                     }
//                   }
//                 }).then((value) {
//                   // Navigator.of(context).pushAndRemoveUntil(
//                   //     MaterialPageRoute(
//                   //         builder: (context) => const FilteringPage()),
//                   //     (route) => false);
//                 });