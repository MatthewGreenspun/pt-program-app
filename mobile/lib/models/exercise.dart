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

// ignore: library_private_types_in_public_api
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
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
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
      this.hours = 0,
      this.minutes = 0,
      this.seconds = 0});

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
  String get fmtWeight {
    if (weight == 0.0) return "no weight";
    return "$weight ${units == Units.metric ? "kg" : "lb"}${weight == 1 ? "" : "s"}";
  }

  @computed
  String get fmtSets {
    if (reps == 0) return "$sets sets";
    return "$sets set${sets == 1 ? "" : "s"} of $reps";
  }

  @computed
  Duration get duration =>
      Duration(hours: hours, minutes: minutes, seconds: seconds);

  @computed
  String get fmtTime {
    if (hours > 0) return "${hours}h ${minutes}m ${seconds}s";
    if (minutes > 0) return "${minutes}m ${seconds}s";
    if (seconds > 0) return "$seconds seconds";
    return "no time";
  }
}
