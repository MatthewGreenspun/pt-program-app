import 'package:mobile/services/exercises.service.dart';
import 'package:mobx/mobx.dart';
import "../models/exercise.dart";
part 'exercises.g.dart';

class ExercisesStore = _Exercises with _$ExercisesStore;

abstract class _Exercises with Store {
  final ExercisesService _exercisesService;
  _Exercises(this._exercisesService);

  final exercises = ObservableList<Exercise>();

  @action
  Future<void> fetchExercises() async {
    final serverExercises = await _exercisesService.getExercises();
    exercises.addAll(serverExercises);
  }
}
