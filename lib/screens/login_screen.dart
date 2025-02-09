import 'package:chatting_app/components/rounded_button.dart';
import 'package:chatting_app/components/rounded_text_field.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  late User signInUser;

  void LoggingInTheUser() async {
    try {
      final userIn = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userIn != null) {
        signInUser = userIn.user!;
        Navigator.pushNamed(
          context,
          ChatScreen.id,
        );
      }
    } catch (e) {
      print(e);
    }
  }

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
              tag: "logo-pic",
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
              onChange: (value) {
                email = value;
              },
              obscuringText: false,
              keyboardInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedTextField(
              hintTExt: "Enter your password",
              onChange: (value) {
                password = value;
              },
              obscuringText: true,
              keyboardInputType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              onPress: () {
                LoggingInTheUser();
              },
              buttonText: "Login",
              buttonColor: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
