import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exercise.g.dart';

enum Units { imperial, metric }

class Exercise {
  String id;
  String name;
  String mediaLink;
  String description;
  Exercise(this.id, this.name, this.mediaLink, this.description);
}

@JsonSerializable()
class ProgramExercise extends _ProgramExercise with _$ProgramExercise {
  ProgramExercise(
      {required super.id,
      required super.exerciseId,
      required super.name,
      super.mediaLink = "",
      super.description = "",
      required super.sets,
      super.reps = 0,
      super.weight = 0,
      super.units = Units.imperial,
      super.notes = "",
      super.isDone = false,
      super.hours = 0,
      super.minutes = 0,
      super.seconds = 0});

  factory ProgramExercise.fromJson(Map<String, dynamic> json) =>
      _$ProgramExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramExerciseToJson(this);
}

abstract class _ProgramExercise with Store {
  String id;
  String exerciseId;
  String name;
  String mediaLink;
  String description;
  @observable
  int sets;
  @observable
  int reps;
  @observable
  double weight;
  Units units;
  String notes;
  @observable
  int hours = 0;
  @observable
  int minutes = 0;
  @observable
  int seconds = 0;
  @observable
  bool isDone;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Timer? timer; // Debounce mechanism for editing the exercise
  _ProgramExercise(
      {required this.id,
      required this.exerciseId,
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
  void setIsDone(bool newIsDone) {
    isDone = newIsDone;
  }

  @action
  void setSets(int newSets) {
    sets = newSets;
  }

  @action
  void setReps(int newReps) {
    reps = newReps;
  }

  @action
  setHours(int newHours) {
    hours = newHours;
  }

  @action
  setMinutes(int newMinutes) {
    minutes = newMinutes;
  }

  @action
  setSeconds(int newSeconds) {
    seconds = newSeconds;
  }

  @action
  void setWeight(double newWeight) {
    weight = newWeight;
  }

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get fmtWeight {
    if (weight == 0.0) return "no weight";
    return "$weight ${units == Units.metric ? "kg" : "lb"}${weight == 1 ? "" : "s"}";
  }

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get fmtSets => "$sets set${sets == 1 ? "" : "s"}";

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get fmtReps => "$reps rep${reps == 1 ? "" : "s"}";

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  Duration get duration =>
      Duration(hours: hours, minutes: minutes, seconds: seconds);

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get fmtTime {
    if (hours > 0) return "${hours}h ${minutes}m ${seconds}s";
    if (minutes > 0) return "${minutes}m ${seconds}s";
    if (seconds > 0) return "$seconds seconds";
    return "no time";
  }

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isTimed => duration != Duration.zero;

  @computed
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get fmtRepsOrTime {
    if (duration != Duration.zero) return fmtTime;
    return fmtReps;
  }
}
