import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double size;
  final bool bold;
  const StyledText(
      {super.key, required this.text, required this.size, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
