import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double? size;
  final bool bold;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final Color? color;
  const StyledText(this.text,
      {super.key,
      this.size,
      this.bold = false,
      this.fontStyle = FontStyle.normal,
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
          fontStyle: fontStyle,
          color: color),
    );
  }
}
