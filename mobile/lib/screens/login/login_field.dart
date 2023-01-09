import "package:flutter/material.dart";

class LoginField extends StatelessWidget {
  TextEditingController controller;
  String label;
  TextInputType inputType;
  bool isPassword;
  EdgeInsetsGeometry margin;
  double width;
  LoginField(
      {super.key,
      required this.controller,
      required this.label,
      this.inputType = TextInputType.text,
      this.isPassword = false,
      this.margin = const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      this.width = 500});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        margin: margin,
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          decoration:
              InputDecoration(border: OutlineInputBorder(), label: Text(label)),
        ));
  }
}
