import 'dart:async';

import 'package:mobile/models/exercise.dart';
import 'package:mobile/models/program.dart';
import 'package:mobile/services/programs.service.dart';
import 'package:mobx/mobx.dart';
import "dart:math";
part 'programs.g.dart';

// ignore: library_private_types_in_public_api
class ProgramsStore = _Programs with _$ProgramsStore;

abstract class _Programs with Store {
  final ProgramsService _programsService;
  _Programs(this._programsService);

  @observable
  int activeIdx = 0;

  @action
  setActiveIdx(int idx) {
    activeIdx = idx;
  }

  final activePrograms = ObservableList<ActiveProgram>();

  @computed
  ActiveProgram get activeProgram => activePrograms[activeIdx];

  @action
  Future<void> addProgram(String id) async {
    if (activePrograms.any((program) => program.id == id)) return;
    final futures = await Future.wait([
      _programsService.getProgram(id),
      _programsService.getProgramExercises(id),
    ]);
    final program = futures[0] as Program;
    final exercises = futures[1] as List<ProgramExercise>;
    final activeProgram = ActiveProgram(
        exercises: ObservableList.of(exercises),
        id: program.id,
        patient: program.patient,
        name: program.name,
        description: program.description);
    activePrograms.add(activeProgram);
    setActiveIdx(activePrograms.length - 1);
  }

  @action
  void popActiveProgram() {
    activePrograms.removeAt(activeIdx);
    activeIdx = max(0, activeIdx - 1);
  }

  @action
  Future<void> editExercise(ProgramExercise exercise,
      {int? sets,
      int? reps,
      double? weight,
      int? hours,
      int? minutes,
      int? seconds}) async {
    exercise.timer?.cancel();
    if (sets != null) exercise.setSets(sets);
    if (reps != null) exercise.setReps(reps);
    if (weight != null) exercise.setWeight(weight);
    if (hours != null) exercise.setHours(hours);
    if (minutes != null) exercise.setMinutes(minutes);
    if (seconds != null) exercise.setSeconds(seconds);
    exercise.timer = Timer(
        const Duration(seconds: 5), // Debounce
        () async => await _programsService.editProgramExercise(exercise));
  }
}
