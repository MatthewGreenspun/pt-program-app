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
    return Consumer<ProgramBuilderStore>(
        builder: (_, programBuilderStore, __) => Observer(
            builder: (_) => Card(
                    child: Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              programBuilderStore.removeExercise(exercise);
                            },
                            icon: const Icon(Icons.delete)),
                        Expanded(
                          child: Text(exercise.name),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            IncrementDecrementButton(
                              delta: 0.5,
                              value: exercise.weight,
                              onPressed: (weight) =>
                                  programBuilderStore.editExercise(exercise.id,
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
                                onPressed: (sets) => programBuilderStore
                                    .editExercise(exercise.id,
                                        sets: sets.toInt())),
                            Text(exercise.fmtSets),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: exercise.isTimed
                              ? [
                                  EditButton(onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            EditTimeModal(exercise: exercise));
                                  }),
                                  Text(exercise.fmtRepsOrTime)
                                ]
                              : [
                                  IconButton(
                                      onPressed: () {
                                        exercise.seconds = 15;
                                      },
                                      icon: const Icon(Icons.timer)),
                                  IncrementDecrementButton(
                                      value: exercise.reps,
                                      onPressed: (reps) => programBuilderStore
                                          .editExercise(exercise.id,
                                              reps: reps.toInt())),
                                  Text(exercise.fmtRepsOrTime)
                                ],
                        )),
                      ]),
                ))));
  }
}
