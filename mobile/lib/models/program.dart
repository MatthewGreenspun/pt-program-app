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

  String get identifier => "$patient $name";
}
