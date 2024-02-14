import 'package:flutter/material.dart';
import 'package:market_app/components/custombuttonauth.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'value is required';
                }
              },
              decoration: InputDecoration(
                  hintText: 'add note',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            SizedBox(height: 32,),
          MaterialButton(
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: (){},
      child: Text('Add'),
    )
          ],
        ),
      ),
    );
  }
}
