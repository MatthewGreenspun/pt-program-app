import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:mobile/stores/index.dart";
import "package:mobile/widgets/index.dart";
import "package:provider/provider.dart";
import "../../models/exercise.dart";

class ProgramExerciseCard extends StatelessWidget {
  final ProgramExercise exercise;
  const ProgramExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramsStore>(
        builder: (_, programsStore, __) => Observer(
            builder: (_) => Card(
                    child: Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                              value: exercise.isDone,
                              onChanged: (value) {
                                exercise.setIsDone(value ?? false);
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            )),
                        Expanded(
                          child: Text(exercise.name),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            IncrementDecrementButton(
                              value: exercise.weight,
                              onPressed: (weight) =>
                                  programsStore.editWeight(exercise, weight),
                            ),
                            Text(exercise.fmtWeight),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(exercise.fmtSets),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Text(exercise.fmtTime),
                          ],
                        )),
                      ]),
                ))));
  }
}
