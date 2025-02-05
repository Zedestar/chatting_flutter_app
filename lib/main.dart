import 'package:chatting_app/screens/chat_screen.dart';
import 'package:chatting_app/screens/login_screen.dart';
import 'package:chatting_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
            // bodyText2: TextStyle(color: Colors.black54),
            ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
