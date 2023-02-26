import 'dart:async';
import 'dart:math';
import 'package:mobile/models/exercise.dart';
import 'package:mobile/models/program.dart';
import 'package:uuid/uuid.dart';
import 'package:mobile/services/programs.service.dart';
import 'package:mobx/mobx.dart';
part 'program_builder.g.dart';

// ignore: library_private_types_in_public_api
class ProgramBuilderStore = _ProgramBuilder with _$ProgramBuilderStore;

abstract class _ProgramBuilder with Store {
  final ProgramsService _programsService;
  _ProgramBuilder(this._programsService);

  @observable
  String programName = "New Program";

  @observable
  String description = "";

  final programExercises = ObservableList<ProgramExercise>();

  @computed
  Set<String> get exerciseIds =>
      programExercises.map((exercise) => exercise.exerciseId).toSet();

  @action
  void addExercise(Exercise exercise) {
    if (exerciseIds.contains(exercise.id)) return;
    final programExercise = ProgramExercise(
        id: const Uuid().v4(),
        exerciseId: exercise.id,
        name: exercise.name,
        sets: 3,
        reps: 10);
    programExercises.add(programExercise);
  }

  @action
  void editExercise(String id,
      {int? sets,
      int? reps,
      double? weight,
      int? hours,
      int? minutes,
      int? seconds}) {
    final exercise =
        programExercises.where((exercise) => exercise.id == id).first;
    if (sets != null) exercise.setSets(sets);
    if (reps != null) exercise.setReps(reps);
    if (weight != null) exercise.setWeight(weight);
    if (hours != null) exercise.setHours(hours);
    if (minutes != null) exercise.setMinutes(minutes);
    if (seconds != null) exercise.setSeconds(seconds);
  }

  @action
  void removeExercise(ProgramExercise exercise) {
    programExercises.remove(exercise);
  }

  Future<void> createProgram(String patientId) async {
    await _programsService.createProgram(
        programName, patientId, programExercises.toList(), description);
  }
}
