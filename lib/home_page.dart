// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_app/components/Custom_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Install'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('login');
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Stack(
        children: [
          GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.5, mainAxisExtent: 155),
            children: [
              const CustomCard(
                categoryName: 'Home',
              ),
              const CustomCard(
                categoryName: 'work',
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: Colors.cyan,
              onPressed: () {
                Navigator.of(context).pushNamed('AddCategoryPage');
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
