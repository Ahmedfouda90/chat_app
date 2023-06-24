import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../consts/consts.dart';
import '../../customs/cusstomIconButton.dart';
import '../../customs/customTextFormField.dart';
import '../../customs/snackMessage.dart';
import '../chatscreen/chatScreen.dart';
import '../logInWithGoogle.dart';
import '../register Screen/registerScreen.dart';

class LogIn extends StatefulWidget {
  LogIn({Key? key, this.email}) : super(key: key);
  static String id = 'LogIn';
  String? email;

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? email;
  String? password;
  bool inAsyncCall = false;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/scholar.png',
                        width: 100,
                        height: 180,
                      ),
                      const Text(
                        'Scholar Chat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'Pacifico',
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        labelText: 'Enter Your Email',
                        hintText: 'Email',
                        onChanged: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        obscureText: isPassword,
                        labelText: 'Enter Your Password',
                        hintText: 'Password',
                        onChanged: (data) {
                          password = data;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomIconButton(
                          iconText: 'SIGN IN',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                inAsyncCall = true;
                                await userLogIn();
                                Navigator.pushNamed(context, ChatPage.id,
                                    arguments: email);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  snackMessage(context, 'user not found ');
                                } else if (e.code == 'wrong-password') {
                                  snackMessage(context, 'wrong password');
                                } else {
                                  snackMessage(context, 'an error occured');
                                }
                              }
                              inAsyncCall = false;
                              setState(() {});
                            }
                          }),
                      SizedBox(height: 20,),
                      CustomIconButton(
                          iconText: 'SIGN IN WITH GOOGLE ',
                          onTap: () async {
                            Navigator.pushNamed(context, Google.id);
                          }
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'dont\'t have an account.',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Register.id);
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        kPrimaryColor),
                                elevation: MaterialStatePropertyAll(.1)),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> userLogIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userLogin = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
