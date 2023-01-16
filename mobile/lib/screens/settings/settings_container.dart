import "package:flutter/material.dart";
import 'package:mobile/widgets/styled_text.dart';

class SettingsContainer extends StatelessWidget {
  final String title;
  final Widget child;
  const SettingsContainer({super.key, this.title = "", required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          StyledText(text: title, size: 25, bold: true),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 3)),
              child: child)
        ]));
  }
}
