import "package:flutter/material.dart";

class LoginField extends StatelessWidget {
  TextEditingController controller;
  String label;
  EdgeInsetsGeometry margin;
  double width;
  LoginField(
      {super.key,
      required this.controller,
      required this.label,
      this.margin = const EdgeInsets.all(8),
      this.width = 500});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        margin: margin,
        child: TextField(
          controller: controller,
          decoration:
              InputDecoration(border: OutlineInputBorder(), label: Text(label)),
        ));
  }
}
