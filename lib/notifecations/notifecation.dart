import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Notfi extends StatefulWidget {
  const Notfi({
    super.key,
  });

  @override
  State<Notfi> createState() => _NotfiState();
}

class _NotfiState extends State<Notfi> {
  String? token;
  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    //print(token);
  }

  requestpermation() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages here
      if (message.notification != null) {
        AwesomeDialog(
                context: context,
                title: message.notification!.title,
                body: Text('${message.notification!.body}'),
                dialogType: DialogType.info)
            .show();
      }
    });
    requestpermation();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notefication'),
        backgroundColor: Colors.blue,
      ),
      body: MaterialButton(
        onPressed: () {
          sendMessage(token!, 'hallo', 'how are you');
        },
        child: const Text('sent massage'),
      ),
    );
  }
}

Future<void> sendMessage(String deviceToken, String title, String body) async {
  // Construct the request body
  var bodyData = jsonEncode({
    'notification': {
      'title': title,
      'body': body,
    },
    'to': deviceToken,
  });

  // Construct the request headers
  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAAI0x5Gtc:APA91bFwS1vqIZEV7Ql7i9gLFOAKHDHCKzEcQF5-sWFudJ0-nBMRsurLbOtMYy4RhMYDDBO-qkTxfKN7Fh9JXILPfP8Fz-2twtlpdmMg2cF5oRRHtguWsf4h0GsxOYKWjJ4EUPuU_IEP',
  };

  // Send the request
  var response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: headers,
    body: bodyData,
  );

  // Check the response status
  if (response.statusCode == 200) {
    print('Message sent successfully.');
  } else {
    print('Failed to send message. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
