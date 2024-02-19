  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:market_app/components/custom_form_textField.dart';
  import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
    bool isLonading = false;

    Future<void> addCategory() async {
      if (formKey.currentState!.validate()) {
        try {
          isLonading = true;
        setState(() {
          
        });
         await categoris.add(
              {'name': name.text, 'id': FirebaseAuth.instance.currentUser!.uid,});
          Navigator.of(context).pushNamed(
            'HomePage',
            
          );
        } catch (e) {
          print(e);
        }
      }
    }
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      name.dispose();
  
    }
    @override
    Widget build(BuildContext context) {
      return ModalProgressHUD(
        inAsyncCall: isLonading,
        child: Scaffold(
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
                    lines: 1,
                    hinttext: 'Enter Name',
                    mycontroller: name,
                    validator: (value) {
                      if (value == '') {
                        return 'value is required';
                      }
                    },
                  ),const SizedBox(
                    height: 20,
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
                    
                    },
                    child: const Text('Add'),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
