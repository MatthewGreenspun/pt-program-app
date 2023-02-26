import "package:flutter/material.dart";
import "../../widgets/index.dart";

class ExerciseCard extends StatelessWidget {
  final String name;
  final String mediaLink;
  final String description;
  const ExerciseCard(
      {super.key,
      required this.name,
      this.description = "",
      this.mediaLink = "assets/images/placeholder_exercise.png"});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyledText(
                  name,
                  size: 30,
                  bold: true,
                  textAlign: TextAlign.left,
                ),
                StyledText(
                  description,
                  size: 15,
                ),
              ]),
        ));
  }
}
