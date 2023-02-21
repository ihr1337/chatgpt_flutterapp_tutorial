import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_flutterapp_tutorial/constants/constants.dart';
import 'package:chatgpt_flutterapp_tutorial/services/assets_manager.dart';
import 'package:chatgpt_flutterapp_tutorial/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImg
                      : AssetsManager.openAiImg,
                  height: 30,
                  width: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: chatIndex == 0
                        ? TextWidget(
                            label: msg,
                          )
                        : DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  msg.trim(),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          ),
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
