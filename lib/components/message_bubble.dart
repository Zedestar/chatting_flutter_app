import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  const MessageBuble({super.key, required this.content, required this.sender});
  final String sender;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$content from $sender',
      style: TextStyle(fontSize: 50.0),
    );
  }
}
