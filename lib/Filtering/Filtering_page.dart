import 'package:flutter/material.dart';

class FilteringPage extends StatelessWidget {
  const FilteringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text('Filter'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('ramy',style: TextStyle(fontSize: 60),),
          Opacity(
            opacity: .6,
            child: Text('age :20',style: TextStyle(fontSize: 22),)),
            Divider(),
              Text('ramez',style: TextStyle(fontSize: 60),),
          Opacity(
            opacity: .6,
            child: Text('age :15',style: TextStyle(fontSize: 22),)),
            Divider(),
          ],
        ),
      ),
    );
  }
}