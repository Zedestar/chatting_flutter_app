import 'package:chatting_app/constants.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {super.key, required this.hintTExt, required this.onChange});
  final ValueChanged<String> onChange;
  final String hintTExt;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      onChanged: onChange,
      decoration: kTextFieldDecorations.copyWith(hintText: hintTExt),
    );
  }
}
