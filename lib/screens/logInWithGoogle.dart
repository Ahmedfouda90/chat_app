import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../consts/consts.dart';
import '../customs/cusstomIconButton.dart';
import '../customs/customTextFormField.dart';
import '../customs/snackMessage.dart';
import 'chatscreen/chatScreen.dart';

class Google extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  String? idToken;
  String? accessToken;
  GoogleSignInAuthentication? googleAuth;


  static String id = 'Google';
  @override
  bool inAsyncCall = false;

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
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  // width: 100,
                  height: 100,
                ),
                Text('Scholar Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 28,
                        color: Colors.white)),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'Sign UP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white),
                      // textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    labelText: 'Enter Your Email',
                    hintText: 'Email',
                    onChanged: (data) {
                      accessToken = data;
                    }),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    obscureText: true,
                    labelText: 'Enter Your Password',
                    hintText: 'Password',
                    onChanged: (data) {
                      idToken = data;
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomIconButton(
                    iconText: 'SIGN IN WITH GOOGLE  ',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await signInWithGoogle();
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if(accessToken!=googleAuth?.accessToken||idToken!= googleAuth?.idToken ){
                            snackMessage(context, 'email or password is wrong');

                          }
                          snackMessage(context, 'an error occurred');
                        }
                      }

                      // print(user.user!.displayName );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
