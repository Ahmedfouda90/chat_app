import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../consts/consts.dart';
import '../../customs/cusstomIconButton.dart';
import '../../customs/customTextFormField.dart';
import '../../customs/snackMessage.dart';
import '../chatscreen/chatScreen.dart';

class Register extends StatefulWidget {
  static String id = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;
  String? password;
  bool inAsyncCall = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: Scaffold(
        appBar: AppBar(),
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
                      email = data;
                    }),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  obscureText: true,
                    labelText: 'Enter Your Password',
                    hintText: 'Password',

                    onChanged: (data) {
                      password = data;
                    }),
              const  SizedBox(
                  height: 20,
                ),
                CustomIconButton(
                    iconText: 'SIGN UP',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          inAsyncCall = true;
                          setState(() {});
                          await userRegister();
                          snackMessage(
                              context, 'success , now you have an account');
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            snackMessage(context, 'weak password');
                          } else if (ex.code == 'email-already-in-use') {
                            snackMessage(context, 'email already existed');
                          } else {
                            snackMessage(context, 'there is an error ');
                          }
                        } catch (x) {
                          print(x);
                        }
                        inAsyncCall = false;
                        setState(() {});
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



  Future<void> userRegister() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
