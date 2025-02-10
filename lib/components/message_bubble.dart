import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  const MessageBuble({super.key, required this.content, required this.sender});
  final String sender;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.4,
            ),
          ),
          Material(
            elevation: 10.0,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                '$content',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
