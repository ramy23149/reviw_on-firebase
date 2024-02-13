// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';


import 'package:market_app/auth/login.dart';
import 'package:market_app/auth/signup.dart';
import 'package:market_app/home_page.dart';


void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('========================User is signed out!');
  //   } else {
  //     print('=========================User is signed in!');
  //   }
  // },);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:// (FirebaseAuth.instance.currentUser!=null &&FirebaseAuth.instance.currentUser!.emailVerified) ? Homepage():
      Login(),
      routes: {"signup": (context) => SignUp(),
       "login": (context) => Login(),
       "HomePage": (context) => Homepage(),
      },
    );
  }
}
