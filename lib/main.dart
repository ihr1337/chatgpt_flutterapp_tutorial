import 'package:chatgpt_flutterapp_tutorial/constants/constants.dart';
import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT FlutterApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(color: cardColor),
      ),
      home: const ChatScreen(),
    );
  }
}
