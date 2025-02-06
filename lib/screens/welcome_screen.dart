import 'package:chatting_app/components/button.dart';
import 'package:chatting_app/screens/login_screen.dart';
import 'package:chatting_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controlingTheLabel;
  late CurvedAnimation controllerAnimate;
  late Animation backgroundColorAnimated;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      // upperBound: 1,
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });

    controllerAnimate =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    _controlingTheLabel = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _controlingTheLabel.forward();
    // _controlingTheLabel.repeat(reverse: true);
    _controlingTheLabel.addListener(() {
      setState(() {});
    });

    backgroundColorAnimated =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controlingTheLabel.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorAnimated.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "logo-pic",
                  child: SizedBox(
                    height: _controlingTheLabel.value * 60,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),

                // color: Colors.black,
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Lets Chart',
                        speed: Duration(milliseconds: 250),
                      ),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            CustomButton(
              onPress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              buttonText: "Login",
              buttonColor: Colors.lightBlueAccent,
            ),
            CustomButton(
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
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
