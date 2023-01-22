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

  String? emailValidator(String? value) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!emailRegex.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (!(value.length >= 7)) {
      return "Password must be at least 7 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        margin: margin,
        child: TextFormField(
          validator: inputType == TextInputType.emailAddress
              ? emailValidator
              : passwordValidator,
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          decoration:
              InputDecoration(border: OutlineInputBorder(), label: Text(label)),
        ));
  }
}
