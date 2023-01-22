import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double size;
  final bool bold;
  final TextAlign textAlign;
  final Color? color;
  const StyledText(this.text,
      {super.key,
      required this.size,
      this.bold = false,
      this.textAlign = TextAlign.left,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: size,
          overflow: TextOverflow.ellipsis,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color),
    );
  }
}
