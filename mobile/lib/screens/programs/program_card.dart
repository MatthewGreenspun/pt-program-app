import "package:flutter/material.dart";
import "../../models/exercise.dart";

class ProgramCard extends StatelessWidget {
  final ExerciseInProgress exercise;
  const ProgramCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(exercise.name),
        const Text("No Weight"),
        const Text("3 sets of 10")
      ]),
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
        activeColor: Theme.of(context).colorScheme.primary,
      ),
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("Add Program"))
      ],
    ));
  }
}
