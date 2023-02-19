import 'package:chatgpt_flutterapp_tutorial/constants/constants.dart';
import 'package:chatgpt_flutterapp_tutorial/services/assets_manager.dart';
import 'package:chatgpt_flutterapp_tutorial/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  AssetsManager.userImg,
                  height: 30,
                  width: 30,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: TextWidget(label: 'Hello, it\'s msg'))
              ],
            ),
          ),
        )
      ],
    );
  }
}
