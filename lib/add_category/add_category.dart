import 'package:flutter/material.dart';
import 'package:market_app/components/custom_form_textField.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextForm(
                hinttext: 'Enter Name',
                mycontroller: name,
                validator: (value) {
                  if (value == '') {
                    return 'value is required';
                  }
                },
              ),
              // TextFormField(
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'value is required';
              //     }
              //   },
              //   decoration: InputDecoration(
              //     hintText: 'add note',
              //     hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              //     contentPadding:
              //         const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              //     filled: true,
              //     fillColor: Colors.grey[200],
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(50),
              //         borderSide: const BorderSide(
              //             color: Color.fromARGB(255, 184, 184, 184))),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       borderSide: const BorderSide(color: Colors.grey),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 32,
              ),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: () {},
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
