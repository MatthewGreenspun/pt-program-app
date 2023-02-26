import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/screens/program_builder/program_exercise_list.dart';
import 'package:mobile/stores/index.dart';
import 'package:provider/provider.dart';
import './exercise_list.dart';

class ProgramBuilder extends StatefulWidget {
  static const String routeName = "program-builder";
  const ProgramBuilder({super.key});

  @override
  State<ProgramBuilder> createState() => _ProgramBuilderState();
}

class _ProgramBuilderState extends State<ProgramBuilder> {
  bool _isEditingName = false;

  @override
  Widget build(BuildContext context) {
    final patientId = ModalRoute.of(context)?.settings.arguments as String;

    return Consumer4<RootStore, ExercisesStore, ProgramBuilderStore,
            PatientsStore>(
        builder: (_, rootStore, exercisesStore, programBuilderStore,
                patientsStore, __) =>
            Observer(
                builder: (_) => Scaffold(
                    appBar: AppBar(
                      title: Column(children: [
                        rootStore.isLoading
                            ? const LinearProgressIndicator(
                                minHeight: 5,
                              )
                            : const Material(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isEditingName
                                  ? Expanded(
                                      child: TextField(
                                      textAlign: TextAlign.center,
                                      onChanged: (value) => programBuilderStore
                                          .programName = value,
                                      autofocus: true,
                                      onTapOutside: (_) {
                                        setState(() {
                                          _isEditingName = false;
                                        });
                                      },
                                      cursorColor:
                                          Theme.of(context).primaryColorLight,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ))
                                  : GestureDetector(
                                      onDoubleTap: () {
                                        setState(() {
                                          _isEditingName = true;
                                        });
                                      },
                                      child: Observer(
                                          builder: (_) => Text(
                                              programBuilderStore.programName)),
                                    )
                            ])
                      ]),
                      actions: [
                        IconButton(
                            onPressed: rootStore.isLoading
                                ? null
                                : () {
                                    rootStore.isLoading = true;
                                    programBuilderStore
                                        .createProgram(patientId)
                                        .then((_) => patientsStore
                                                .fetchPatients()
                                                .then((_) {
                                              rootStore.isLoading = false;
                                              Navigator.pop(context);
                                            }));
                                  },
                            icon: const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(Icons.done)))
                      ],
                    ),
                    body: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: ProgramExerciseList())),
                            ExerciseList(
                              allExercises: exercisesStore.exercises,
                            )
                          ],
                        )))));
  }
}
