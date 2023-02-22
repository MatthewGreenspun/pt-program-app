import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:mobile/stores/index.dart";
import "package:provider/provider.dart";
import 'program_exercise_card.dart';

class ProgramContainer extends StatelessWidget {
  const ProgramContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramsStore>(
        builder: (_, programsStore, __) => Observer(
              builder: (_) => Column(
                  children: programsStore.activeProgram.exercises
                      .map(
                        (e) => ProgramExerciseCard(exercise: e),
                      )
                      .toList()),
            ));
  }
}
