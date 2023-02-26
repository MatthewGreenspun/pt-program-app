import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import './program_exercise_card.dart';
import '/stores/program_builder.dart';
import 'package:provider/provider.dart';
import '../../models/exercise.dart';
import '../../widgets/index.dart';

class ProgramExerciseList extends StatefulWidget {
  const ProgramExerciseList({super.key});

  @override
  State<ProgramExerciseList> createState() => _ProgramExerciseListState();
}

class _ProgramExerciseListState extends State<ProgramExerciseList> {
  Exercise? _dragExercise;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramBuilderStore>(
        builder: (_, programBuilderStore, __) => DragTarget<Exercise>(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Observer(
                  builder: (_) => ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          ...programBuilderStore.programExercises
                              .map((exercise) =>
                                  ProgramExerciseCard(exercise: exercise))
                              .toList(),
                          _dragExercise != null
                              ? DottedBorder(
                                  strokeWidth: 4,
                                  strokeCap: StrokeCap.round,
                                  borderType: BorderType.RRect,
                                  color: Theme.of(context).hintColor,
                                  dashPattern: const [8],
                                  radius: const Radius.circular(12),
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: SizedBox(
                                        height: 60,
                                        child: Center(
                                            child: StyledText(
                                          _dragExercise?.name ?? "",
                                          bold: true,
                                          size: 20,
                                        )),
                                      )))
                              : const Material()
                        ],
                      ));
            }, onAccept: (Exercise data) {
              programBuilderStore.addExercise(data);
              setState(() {
                _dragExercise = null;
              });
            }, onWillAccept: (data) {
              if (data is Exercise) {
                setState(() {
                  _dragExercise = data;
                });
                return true;
              }
              return false;
            }, onLeave: (data) {
              setState(() {
                _dragExercise = null;
              });
            }));
  }
}
