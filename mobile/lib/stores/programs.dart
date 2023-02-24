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
  Future<void> editWeight(ProgramExercise exercise, double weight) async {
    exercise.timer?.cancel();
    exercise.setWeight(weight);
    exercise.timer = Timer(const Duration(seconds: 10),
        () async => await _programsService.editProgramExercise(exercise));
  }
}
