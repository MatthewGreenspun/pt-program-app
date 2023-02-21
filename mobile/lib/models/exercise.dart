import 'package:mobx/mobx.dart';
part 'exercise.g.dart';

enum Units { imperial, metric }

class Exercise {
  String id;
  String name;
  String mediaLink;
  String description;
  Exercise(this.id, this.name, this.mediaLink, this.description);
}

class ProgramExercise = _ProgramExercise with _$ProgramExercise;

abstract class _ProgramExercise with Store {
  String id;
  String name;
  String mediaLink;
  String description;
  int sets;
  int reps;
  double weight;
  Units units;
  String notes;
  Duration duration;
  @observable
  bool isDone;
  _ProgramExercise(
      {required this.id,
      required this.name,
      this.mediaLink = "",
      this.description = "",
      required this.sets,
      this.reps = 0,
      this.weight = 0,
      this.units = Units.imperial,
      this.notes = "",
      this.isDone = false,
      int hours = 0,
      int minutes = 0,
      int seconds = 0})
      : duration = Duration(hours: hours, minutes: minutes, seconds: seconds);

  @override
  String toString() {
    return """

$name
$sets sets of $reps
$weight ${units == Units.imperial ? "lbs" : "kgs"}
$duration
""";
  }

  @action
  void setIsDone(bool _isDone) {
    isDone = _isDone;
  }

  @computed
  String get fmtWeight =>
      "$weight ${units == Units.metric ? "kg" : "lb"}${weight == 1 ? "" : "s"}";

  @computed
  String get fmtSets => "$sets set${sets == 1 ? "" : "s"} of $reps";
}
