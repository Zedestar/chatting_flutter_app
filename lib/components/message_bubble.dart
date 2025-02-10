import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  const MessageBuble(
      {super.key,
      required this.content,
      required this.sender,
      required this.loggedInUser});
  final String sender;
  final String content;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: loggedInUser.email == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
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
            borderRadius: loggedInUser.email == sender
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color: loggedInUser.email == sender
                ? Colors.lightBlueAccent
                : Colors.blueAccent,
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
