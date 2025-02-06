import 'package:chatting_app/components/rounded_button.dart';
import 'package:chatting_app/components/rounded_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              onChange: (value) {},
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedTextField(
              hintTExt: "Enter your password",
              onChange: (value) {},
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              onPress: () {
                // Navigator.pushNamed(context, RegistrationScreen.id);
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
