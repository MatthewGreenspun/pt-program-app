import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:mobile/screens/programs/edit_time_modal.dart";
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
                              delta: 0.5,
                              value: exercise.weight,
                              onPressed: (weight) => programsStore.editExercise(
                                  exercise,
                                  weight: weight.toDouble()),
                            ),
                            Text(exercise.fmtWeight),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            IncrementDecrementButton(
                                value: exercise.sets,
                                onPressed: (sets) => programsStore.editExercise(
                                    exercise,
                                    sets: sets.toInt())),
                            Text(exercise.fmtSets),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            exercise.isTimed
                                ? EditButton(onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            EditTimeModal(exercise: exercise));
                                  })
                                : IncrementDecrementButton(
                                    value: exercise.reps,
                                    onPressed: (reps) =>
                                        programsStore.editExercise(exercise,
                                            reps: reps.toInt())),
                            Text(exercise.fmtRepsOrTime),
                          ],
                        )),
                      ]),
                ))));
  }
}
