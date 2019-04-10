import 'package:flutter/material.dart';
import 'package:friendly_chat/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendly chat',

      home: ChatScreen(),
    );
  }
}