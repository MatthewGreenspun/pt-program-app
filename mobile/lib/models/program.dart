import "package:mobx/mobx.dart";

import "./exercise.dart";

class Program {
  String id;
  String patient;
  String name;
  String? description;
  Program(
    this.id,
    this.patient,
    this.name,
    this.description,
  );

  @override
  String toString() {
    return """
id: $id
patient name: $patient
program name: $name
description: $description
""";
  }
}

class ActiveProgram extends Program {
  DateTime date;
  ObservableList<ProgramExercise> exercises;

  ActiveProgram(
      {required this.exercises,
      required String id,
      required String patient,
      required String name,
      String? description,
      DateTime? date})
      : date = date ?? DateTime.now(),
        super(id, patient, name, description);

  @override
  String toString() {
    return """

id: $id
patient name: $patient
program name: $name
description: $description
date: $date
exercises: $exercises
""";
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is! ActiveProgram) return false;
    if (other.id != id) return false;
    return true;
  }

  String get identifier => "$patient $name";
}

class ProgramData {
  String id;
  String name;
  ProgramData(this.id, this.name);

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is! ProgramData) return false;
    if (other.id != id) return false;
    if (other.name != name) return false;
    return true;
  }
}
