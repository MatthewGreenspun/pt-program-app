class Exercise {
  String id;
  String name;
  int sets;
  double weight;
  int reps;
  double time;
  String? mediaLink;
  String? notes;
  Exercise(this.id, this.name, this.weight, this.sets, this.reps, this.time,
      this.mediaLink, this.notes);
}

class ExerciseInProgress extends Exercise {
  bool isDone;
  ExerciseInProgress(
      {required String id,
      required String name,
      required int sets,
      double weight = 0,
      int reps = 0,
      double time = 0,
      String mediaLink = "",
      String notes = "",
      this.isDone = false})
      : super(id, name, weight, sets, reps, time, mediaLink, notes);
}
