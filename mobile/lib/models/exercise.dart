class Exercise {
  String id;
  String name;
  String mediaLink;
  String description;
  Exercise(this.id, this.name, this.mediaLink, this.description);
}

class ProgramExercise extends Exercise {
  int sets;
  int reps;
  int time;
  double weight;
  bool isDone;
  String notes;
  ProgramExercise(
      {required String id,
      required String name,
      required this.sets,
      this.weight = 0,
      this.reps = 0,
      this.time = 0,
      String mediaLink = "",
      String description = "",
      this.notes = "",
      this.isDone = false})
      : super(id, name, mediaLink, description);
}
