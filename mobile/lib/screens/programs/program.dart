import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:mobile/stores/index.dart";
import "package:provider/provider.dart";
import "../../models/exercise.dart";
import "./program_card.dart";

class Program extends StatelessWidget {
  const Program({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramsStore>(
        builder: (_, programsStore, __) => Observer(
              builder: (_) => Column(
                  children: programsStore.activeProgram.exercises
                      .map(
                        (e) => ProgramCard(exercise: e),
                      )
                      .toList()),
            ));
  }
}
