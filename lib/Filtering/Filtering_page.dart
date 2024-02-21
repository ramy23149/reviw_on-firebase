import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilteringPage extends StatefulWidget {
  const FilteringPage({super.key});
  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  List<QueryDocumentSnapshot> data = [];

  Future<void> initalData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await users.orderBy('age', descending: false).get();
    querySnapshot.docs.forEach((element) {
      data.add(element);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initalData();
  }

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
            DocumentReference doc2 = users.doc('2');

            batch.set(doc1, {'name': 'nagwa', 'age': 49, 'money': 600});
            batch.set(doc2, {'name': 'hany', 'age': 50, 'money': 400});
            batch.commit();
          }),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return UserInfo(
              onTap: () {
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection('users')
                    .doc(data[index].id);

                FirebaseFirestore.instance.runTransaction((transaction) async {
                  DocumentSnapshot snapshot =
                      await transaction.get(documentReference);

                  if (snapshot.exists) {
                    var snapShotData = snapshot.data();

                    if (snapShotData is Map<String, dynamic>) {
                      int money = snapShotData['money'] + 100;
                      transaction.update(documentReference, {'money': money});
                    }
                  }
                }).then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const FilteringPage()),
                      (route) => false);
                });
              },
              money: data[index]['money'],
              age: data[index]['age'],
              name: data[index]['name'],
            );
          }),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo(
      {super.key,
      required this.age,
      required this.name,
      required this.money,
      this.onTap});
  final int age;
  final String name;
  final double money;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        //dh el 7al ely momken y3ml m4akel lano y3tamed 3la il data ely 3la el 4a4a
        // onTap: () {
        //         DocumentReference doc = FirebaseFirestore.instance
        //             .collection('users')
        //             .doc(data[index].id);

        //         doc.update({'money':data[index]['money']+100});

        //         Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(
        //                 builder: (context) => const FilteringPage()),
        //             (route) => false);
        //       },
        //el 7al el salem fo2
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 60),
            ),
            Align(
                heightFactor: 0,
                alignment: Alignment.centerRight,
                child: Text(
                  '$money\$',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                )),
            Opacity(
                opacity: .6,
                child: Text(
                  'age :$age',
                  style: const TextStyle(fontSize: 22),
                )),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
