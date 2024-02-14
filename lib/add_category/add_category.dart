import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference categoris =
      FirebaseFirestore.instance.collection('categoris');

  Future<void> addCategory() async {
    if (formKey.currentState!.validate()) {
      try {
    DocumentReference response =    await categoris.add({
          'name': name.text,
        });
        Navigator.of(context).pushReplacementNamed('HomePage');
      } catch (e) {
        print(e);
      }
    }
  }

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
              const SizedBox(
                height: 32,
              ),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: () {
                  addCategory();
                  name.clear();
                },
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
