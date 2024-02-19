import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/components/custom_form_textField.dart';
import 'package:market_app/note/view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditNote extends StatefulWidget {
  const EditNote({
    super.key,
    required this.noteDocId,
    required this.categoryDocId,
    required this.categoryName,
  });
  final String noteDocId;
  final String categoryDocId;
  final String categoryName;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  bool isLonading = false;

  Future<void> editCategory() async {
    try {
      CollectionReference categoris = FirebaseFirestore.instance
          .collection('categoris')
          .doc(widget.categoryDocId)
          .collection('note');

      await categoris.doc(widget.noteDocId).update({'note': note.text});
     Navigator.push(
        
      context,
      MaterialPageRoute(
        
          builder: (context) => NoteView(
                docId:widget.categoryDocId,
              ))
              
              );
      
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note.text = widget.categoryName;
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
                    editCategory();
                  },
                  child: const Text('Edit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
