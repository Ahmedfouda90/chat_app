
import 'package:chat_app_with_tharwat_14_5_2023/screens/chatscreen/chatScreen.dart';
import 'package:chat_app_with_tharwat_14_5_2023/screens/logInScreen/logIn.dart';
import 'package:chat_app_with_tharwat_14_5_2023/screens/logInWithGoogle.dart';
import 'package:chat_app_with_tharwat_14_5_2023/screens/register%20Screen/registerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());

}
class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
       LogIn.id:(context)=>LogIn(),
       Register.id:(context)=>Register(),
        ChatPage.id:(context)=>ChatPage(),
      },
      initialRoute: 'LogIn',
      // home: LogIn(),
    );
  }
}
