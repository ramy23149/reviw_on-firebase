import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Image.network(
                'https://cdn1.iconfinder.com/data/icons/document-management-2/64/Floder-document-managment-data-office-64.png'),
          ),
          // SizedBox(height: 20,),
           Text(
            categoryName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
