import 'dart:developer';

import 'package:chatgpt_flutterapp_tutorial/constants/constants.dart';
import 'package:chatgpt_flutterapp_tutorial/models/chat_model.dart';
import 'package:chatgpt_flutterapp_tutorial/services/api_services.dart';
import 'package:chatgpt_flutterapp_tutorial/services/assets_manager.dart';
import 'package:chatgpt_flutterapp_tutorial/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';
import '../services/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openAiImg),
          ),
          title: const Text('ChatGPT'),
          actions: [
            IconButton(
              onPressed: () async {
                await Services.showModalSheet(context: context);
              },
              icon: const Icon(Icons.more_vert_rounded),
            )
          ],
        ),
        body: Center(
          child: SafeArea(
              child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: ((context, index) {
                      return ChatWidget(
                        msg: chatList[index].msg,
                        chatIndex: chatList[index].chatIndex,
                      );
                    })),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_isTyping) ...[
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 18,
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              Material(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await sendMessageFCT(
                                modelsProvider: modelsProvider);
                          },
                          decoration: const InputDecoration.collapsed(
                              hintText: 'How can I help you?',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await sendMessageFCT(
                                modelsProvider: modelsProvider);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider}) async {
    try {
      setState(() {
        _isTyping = true;
      });
      chatList = await ApiService.sendMessage(
          message: textEditingController.text,
          modelId: modelsProvider.getCurrentModel);
      setState(() {});
    } catch (error) {
      // print('error: $error');
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }
}
