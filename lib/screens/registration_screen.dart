import 'package:chatting_app/components/rounded_button.dart';
import 'package:chatting_app/components/rounded_text_field.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo-pic',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedTextField(
              hintTExt: "Enter your email",
              obscuringText: false,
              keyboardInputType: TextInputType.emailAddress,
              onChange: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedTextField(
              hintTExt: "Enter your password",
              keyboardInputType: TextInputType.visiblePassword,
              obscuringText: true,
              onChange: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              onPress: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
              buttonText: "Register",
              buttonColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
