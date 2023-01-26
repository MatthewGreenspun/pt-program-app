import '../models/exercise.dart';
import './base.service.dart';

class ExercisesService extends BaseService {
  ExercisesService() : super();

  Future<List<Exercise>> getExercises() async {
    final res = await request("/exercises", Method.get);
    if (res['exercises'] != null) {
      final exercises = (res['exercises'] as List<dynamic>)
          .map((exercise) => Exercise(exercise['id'], exercise['name'],
              exercise['mediaLink'], exercise['description']))
          .toList();
      return exercises;
    } else {
      throw "Failed to fetch exercises";
    }
  }
}
