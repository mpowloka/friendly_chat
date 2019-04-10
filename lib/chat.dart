import 'package:flutter/material.dart';
import 'package:friendly_chat/chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _messages = <ChatMessage>[];

  final _textController = TextEditingController();

  var _isComposing = false;
  var localUser = true;

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friendly chat"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, index) => _messages[index],
            ),
          ),
          Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }

  _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleTextSubmitted,
                onChanged: (text) => setState(() {
                      _isComposing = text.isNotEmpty;
                    }),
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleTextSubmitted(_textController.text)
                  : null,
            )
          ],
        ),
      ),
    );
  }

  _handleTextSubmitted(String text) {
    setState(() {
      final message = ChatMessage(
        username: localUser ? "Obi-Wan Kenobi" : "General Grievous",
        message: text,
        localUser: localUser,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)),
      );

      _messages.insert(0, message);

      message.animationController.forward();

      localUser = !localUser;
      _isComposing = false;
      _textController.clear();
    });
  }
}
