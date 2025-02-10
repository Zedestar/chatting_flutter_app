import 'package:chatting_app/components/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuilderMessages extends StatelessWidget {
  BuilderMessages({super.key, required this.currentUser});

  final _firestore = FirebaseFirestore.instance;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("messages").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("There is an error occured");
        }
        if (!snapshot.hasData) {
          return Text("There is no data available");
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBuble> messagesWidget = [];
        for (var message in messages) {
          final messageData = message.data() as Map<String, dynamic>;
          final String sender = messageData['sender'];
          final String content = messageData['content'];
          messagesWidget.add(
            MessageBuble(
              content: content,
              sender: sender,
              loggedInUser: currentUser,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            children: messagesWidget,
          ),
        );
      },
    );
  }
}
