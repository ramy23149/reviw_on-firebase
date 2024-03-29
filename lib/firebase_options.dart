// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqbrQ-GCk6UON6VBn99Iu60lGSQhIiiYM',
    appId: '1:151606860503:web:cec424678b530e3c2f6e92',
    messagingSenderId: '151606860503',
    projectId: 'reviwe-on-firebase',
    authDomain: 'reviwe-on-firebase.firebaseapp.com',
    storageBucket: 'reviwe-on-firebase.appspot.com',
    measurementId: 'G-7G3W148R04',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-yVHXnrd5l0889hmkQseUQZr0E3L4wWs',
    appId: '1:151606860503:android:af37124264cf5f972f6e92',
    messagingSenderId: '151606860503',
    projectId: 'reviwe-on-firebase',
    storageBucket: 'reviwe-on-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeeSXnBkTSe0CXme6iD5b_LZ6AENGyJAw',
    appId: '1:151606860503:ios:46a7d0b7be3516842f6e92',
    messagingSenderId: '151606860503',
    projectId: 'reviwe-on-firebase',
    storageBucket: 'reviwe-on-firebase.appspot.com',
    iosBundleId: 'com.example.marketApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDeeSXnBkTSe0CXme6iD5b_LZ6AENGyJAw',
    appId: '1:151606860503:ios:2d8c5dcbbb866a102f6e92',
    messagingSenderId: '151606860503',
    projectId: 'reviwe-on-firebase',
    storageBucket: 'reviwe-on-firebase.appspot.com',
    iosBundleId: 'com.example.marketApp.RunnerTests',
  );
}
