import 'package:chatting_app/constants.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {super.key,
      required this.hintTExt,
      required this.onChange,
      required this.keyboardInputType,
      required this.obscuringText});
  final ValueChanged<String> onChange;
  final String hintTExt;
  final TextInputType keyboardInputType;
  final bool obscuringText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardInputType,
      obscureText: obscuringText,
      maxLength: 200,
      maxLines: 1,
      textAlign: TextAlign.center,
      onChanged: onChange,
      decoration: kTextFieldDecorations.copyWith(hintText: hintTExt),
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
