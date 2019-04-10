import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String username;
  final String message;
  final bool localUser;

  final AnimationController animationController;

  const ChatMessage(
      {Key key,
      this.username,
      this.message,
      this.animationController,
      this.localUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Container(
        padding: EdgeInsets.only(
            right: localUser ? 16.0 : 0, left: localUser ? 0.0 : 16.0),
        child: CircleAvatar(
          backgroundColor: localUser ? Colors.green : Colors.purple,
          child: Text(username[0]),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment:
              localUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              username,
              style: Theme.of(context).textTheme.subhead,
            ),
            Container(
              margin: EdgeInsets.only(top: 4.0),
              child: Text(
                message,
              ),
            )
          ],
        ),
      )
    ];

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment:
              localUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: localUser ? children : children.reversed.toList(),
        ),
      ),
    );
  }
}
