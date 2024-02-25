import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notfi extends StatefulWidget {
  const Notfi({super.key});

  @override
  State<Notfi> createState() => _NotfiState();
}

class _NotfiState extends State<Notfi> {
  Future<void> getToken() async {
    String? myToken = await FirebaseMessaging.instance.getToken();
    print(myToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notefication'),
        backgroundColor: Colors.blue,
      ),
      body: Container(),
    );
  }
}
