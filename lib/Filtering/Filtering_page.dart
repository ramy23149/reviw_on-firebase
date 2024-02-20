
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
        await users.orderBy('age',descending: false).startAfter([22]).get();
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
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return UserInfo(
              age: data[index]['age'],
              name: data[index]['name'],
            );
          }),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.age, required this.name});
  final int age;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 60),
          ),
          Opacity(
              opacity: .6,
              child: Text(
                'age :$age',
                style: const TextStyle(fontSize: 22),
              )),
          const Divider(),
        ],
      ),
    );
  }
}
