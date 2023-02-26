import 'package:mobile/models/exercise.dart';

import '../models/program.dart';
import './base.service.dart';

class ProgramsService extends BaseService {
  ProgramsService() : super();

  Future<Program> getProgram(String id) async {
    final res = await request("/programs/$id", Method.get);
    if (res['program'] != null) {
      final program = res['program'];
      return Program(program['id'], program['patient'], program['name'],
          program['description']);
    } else if (res['error'] != null) {
      throw res['error'];
    } else {
      throw "Failed to fetch program";
    }
  }

  Future<void> createProgram(String name, String patientId,
      List<ProgramExercise> exercises, String description) async {
    final res = await request("/programs", Method.post, data: {
      "name": name,
      "patientId": patientId,
      "exercises": exercises,
      "description": description
    });
    if (res['error'] != null) {
      throw res['error'];
    }
  }

  Future<List<ProgramExercise>> getProgramExercises(String id) async {
    final res = await request("/programs/exercises/$id", Method.get);
    if (res['exercises'] != null) {
      final exercises = (res['exercises'] as List<dynamic>)
          .map((e) => ProgramExercise(
              id: e['id'],
              exerciseId: e['exerciseId'],
              name: e['name'],
              sets: e['sets'],
              reps: e['reps'],
              weight: double.parse(e['weight']),
              units: e['units'] == 'metric' ? Units.metric : Units.imperial,
              mediaLink: e['mediaLink'],
              notes: e['notes'],
              description: e['description'],
              hours: e['hours'],
              minutes: e['minutes'],
              seconds: e['seconds'],
              isDone: false))
          .toList();
      return exercises;
    } else if (res['error'] != null) {
      throw res['error'];
    } else {
      throw "Failed to fetch program exercises";
    }
  }

  Future<void> editProgramExercise(ProgramExercise exercise) async {
    await request("/programs/exercises/", Method.put, data: exercise.toJson());
  }
}
