

import '../consts/consts.dart';

class MessageModel {
  final String messageText;
  final String id;
  MessageModel(this.messageText,this.id);
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kMessageText],jsonData['id']);
  }
}
