import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/components/custom_form_textField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateCategoryPage extends StatefulWidget {
  const UpdateCategoryPage({
    super.key,
    required this.docId,
    required this.oldName,
    required this.oldSubject,
  });
  final String docId;
  final String oldName;
  final dynamic oldSubject;

  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController subject = TextEditingController();
  CollectionReference categoris =
      FirebaseFirestore.instance.collection('categoris');
  bool isLonading = false;

  Future<void> updateCategory() async {
    if (formKey.currentState!.validate()) {
      try {
        isLonading = true;
        setState(() {});
        await categoris.doc(widget.docId).set(
            {'name': name.text, 'subject': subject.text},
            SetOptions(merge: true));
        Navigator.of(context).pushNamedAndRemoveUntil(
          'HomePage',
          (route) => false,
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
    subject.dispose();
  }

  @override
  void initState() {
    subject.text = widget.oldSubject;
    name.text = widget.oldName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLonading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Edit Note'),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextForm(
                  lines: 4,
                  hinttext: 'subject',
                  mycontroller: subject,
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'value is required';
                  //   }
                  // },
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
                    updateCategory();
                  },
                  child: const Text('save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
