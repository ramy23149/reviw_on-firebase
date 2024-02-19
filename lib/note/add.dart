import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/components/custom_form_textField.dart';
import 'package:market_app/note/view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.docId});
  final String docId;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();


  bool isLonading = false;

  Future<void> addCategory() async {
    try {
        CollectionReference categoris = FirebaseFirestore.instance
      .collection('categoris')
      .doc(widget.docId)
      .collection('note');
      isLonading = true;
      setState(() {});
     await categoris.add({'note': note.text});
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoteView(docId: widget.docId,)));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
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
                  mycontroller: note,
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
