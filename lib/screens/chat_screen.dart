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

  // void getMessages() async {
  //   try {
  //     final messageCollection = await _firestore.collection('messages').get();
  //     for (var mesage in messageCollection.docs) {
  //       print(mesage.data());
  //     }
  //   } catch (e) {
  //     print("There was an error $e");
  //   }
  // }

  void messagesStream() async {
    await for (var snapShot in _firestore.collection('messages').snapshots()) {
      for (var message in snapShot.docs) {
        print(message.data());
      }
    }
  }

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
                // _auth.signOut();
                // Navigator.pop(context);
                // getMessages();
                messagesStream();
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
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("messages").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("There is an error occured");
                  }
                  if (!snapshot.hasData) {
                    return Text("There is no data available");
                  }
                  final messages = snapshot.data!.docs;
                  List<Text> messagesWidget = [];
                  for (var message in messages) {
                    final messageData = message.data() as Map<String, dynamic>;
                    final String sender = messageData['sender'];
                    final String content = messageData['content'];
                    //

                    messagesWidget.add(messageContent);
                  }
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      children: messagesWidget,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
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
                        message = '';
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
