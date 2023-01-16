import "package:flutter/material.dart";

class ColorPicker extends StatelessWidget {
  final List<MaterialColor> choices;
  final int selectedIdx;
  final dynamic Function(MaterialColor) onChange;
  final double boxWidth;
  final EdgeInsetsGeometry margin;
  const ColorPicker(
      {super.key,
      required this.choices,
      required this.selectedIdx,
      required this.onChange,
      this.boxWidth = 20,
      this.margin = const EdgeInsets.all(8)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: choices
            .asMap()
            .entries
            .map((entry) => GestureDetector(
                onTap: () => onChange(choices[entry.key]),
                child: Container(
                  width: boxWidth,
                  height: boxWidth,
                  color: selectedIdx == entry.key
                      ? entry.value.withOpacity(1.0)
                      : entry.value.withOpacity(0.2),
                )))
            .toList(),
      ),
    );
  }
}
