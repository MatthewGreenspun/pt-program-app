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

  void onEdit() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Make more responsive
    final deviceWidth = MediaQuery.of(context).size.width;
    final containerWidth = deviceWidth > 500 ? (deviceWidth / 3) : deviceWidth;
    return Container(
      width: containerWidth,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          border: Border.all(color: Theme.of(context).hintColor, width: 1)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: StyledText(
                name,
                size: 30,
                bold: true,
                textAlign: TextAlign.left,
              )),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
              )
            ]),
            StyledText(
              description,
              size: 15,
            ),
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.asset(
                  mediaLink,
                ))
          ]),
    );
  }
}
