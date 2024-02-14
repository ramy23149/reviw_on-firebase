// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market_app/add_category/add_category.dart';
 import 'package:market_app/auth/login.dart';
import 'package:market_app/auth/signup.dart';
import 'package:market_app/home_page.dart';
import 'firebase_options.dart';
void main() async {
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[50],
        titleTextStyle: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.orange),
       iconTheme: IconThemeData(color: Colors.orange,size: 32)
        )
      ),
      debugShowCheckedModeBanner: false,
      home:  (FirebaseAuth.instance.currentUser!=null && FirebaseAuth.instance.currentUser!.emailVerified) ? Homepage():
          Login(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "HomePage": (context) => Homepage(),
        'AddCategoryPage':(context) => AddCategoryPage()
      },
    );
  }
}
