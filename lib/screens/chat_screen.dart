import 'package:chatting_app/components/message_bubble.dart';
import 'package:chatting_app/components/stream_builder.dart';
import 'package:chatting_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedUser;
  late String message;
  TextEditingController textEditingController = TextEditingController();

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print("The logged user ${loggedUser.email}");
      } else {
        Navigator.pushNamed(
          context,
          LoginScreen.id,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // void messagesStream() async {
  //   await for (var snapShot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapShot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BuilderMessages(
              currentUser: loggedUser,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (message.isEmpty) {
                        return;
                      } else {
                        _firestore.collection('messages').add({
                          'sender': loggedUser.email,
                          'content': message,
                        });
                        textEditingController.clear();
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
