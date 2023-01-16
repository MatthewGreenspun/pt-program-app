import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import "../../widgets/bottom_navigation.dart";
import "./patients_list.dart";
import "../../models/user.dart";

class Patients extends StatefulWidget {
  static const routeName = "/patients";
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: PatientsList(patients: [
          User("", "Matthew", UserType.patient,
              "test@test.com"), //TODO fetch from backend
          User("", "Matthew", UserType.patient, "test@test.com"),
          User("", "Matthew", UserType.patient, "test@test.com"),
          User("", "Matthew", UserType.patient, "test@test.com"),
          User("", "Matthew", UserType.patient, "test@test.com"),
          User("", "Matthew", UserType.patient, "test@test.com"),
        ]));
  }
}

class AddPatientsButton extends StatelessWidget {
  const AddPatientsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add));
  }
}
