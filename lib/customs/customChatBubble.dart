import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../model/messageModel.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({Key? key, required this.message}) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // height: 70,
        padding:const EdgeInsets.all(24),

        margin:const EdgeInsets.all(8),
        decoration:const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              // bottomRight: Radius.circular(16),
              bottomLeft:Radius.circular(32),
            )),
        child: Text(
          message.messageText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubleTwo extends StatelessWidget {
  ChatBubleTwo({Key? key, required this.message}) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // height: 70,
        padding:const EdgeInsets.all(24),

        margin:const EdgeInsets.all(8),
        decoration:const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              // bottomLeft: Radius.circular(16),
            )),
        child: Text(
          message.messageText,
          style:const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
