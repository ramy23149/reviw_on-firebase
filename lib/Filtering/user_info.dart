import 'package:flutter/material.dart';

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
