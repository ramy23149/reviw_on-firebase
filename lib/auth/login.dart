import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:market_app/components/custom_form_textField.dart';
import 'package:market_app/components/custombuttonauth.dart';
import 'package:market_app/components/customlogoauth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    isLoading = true;
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50),
                  const CustomLogoAuth(),
                  Container(height: 20),
                  const Text("Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Container(height: 10),
                  const Text("Login To Continue Using The App",
                      style: TextStyle(color: Colors.grey)),
                  Container(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                    lines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value is required';
                        }
                      },
                      hinttext: "ُEnter Your Email",
                      mycontroller: email),
                  Container(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(height: 10),
                  CustomTextForm(  lines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value is required';
                        }
                      },
                      hinttext: "ُEnter Your Password",
                      mycontroller: password),
                  InkWell(
                    onTap: () async {
                      if (email.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('enter your email first'),
                          ),
                        );
                        return;
                      } else {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Check your gmail',
                            desc:
                                'please check your gmail to reseat your password',
                          ).show();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'This email does not exist. Please enter a valid email.'),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtonAuth(
                title: "login",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      if (credential.user!.emailVerified) {
                        Navigator.of(context).pushReplacementNamed('HomePage');
                      } else {
                          isLoading = false;
                          setState(() {
                            
                          });
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'verify your account',
                          desc: 'please check your gmail to verify you account',
                        ).show();
                      
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == e.code) {
                          isLoading = false;
                            setState(() {
                            
                          });
                        print(e);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Wrong email or password',
                        ).show();
                  
                      }
                    }
                  
                  }
                }),
            Container(height: 20),

            MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.red[700],
                textColor: Colors.white,
                onPressed: () async {
                  final UserCredential? userCredential =
                      await signInWithGoogle();
                  if (userCredential != null) {
                    Navigator.of(context).pushNamed('HomePage');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Login With Google  "),
                    Image.asset(
                      "images/4.png",
                      width: 20,
                    )
                  ],
                )),
            Container(height: 20),
            // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("signup");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Don't Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Register",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
