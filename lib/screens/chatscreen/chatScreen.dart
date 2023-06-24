import 'package:chat_app_with_tharwat_14_5_2023/screens/logInScreen/logIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../consts/consts.dart';
import '../../customs/customChatBubble.dart';
import '../../customs/customTextField.dart';
import '../../model/messageModel.dart';


class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();
  Future signOut()  async{
    await FirebaseAuth.instance.signOut();

    return Navigator.pushNamed(context, LogIn.id);
  }

  // FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionText);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(onPressed: ()async {
                 await  signOut();

                }, icon: Icon(Icons.logout_sharp))
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 70,
                  ),
                  Text('Chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messageList[index].id == email
                            ? ChatBuble(
                                message: messageList[index],
                              )
                            : ChatBubleTwo(message: messageList[index]);
                        // ChatBuble(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: CustomTextField(
                    controller: controller,
                    hintText: 'send message',
                    suffixIcon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onSubmitted: (data) {
                      messages.add({
                        kMessageText: data,
                        kCreatedAt: DateTime.now(),
                        kid: email
                      });
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
