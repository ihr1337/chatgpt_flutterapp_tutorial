import 'package:chatgpt_flutterapp_tutorial/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../services/api_services.dart';

class ChatsProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatlist {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg,
      modelId: chosenModelId,
    ));
    notifyListeners();
  }
}
