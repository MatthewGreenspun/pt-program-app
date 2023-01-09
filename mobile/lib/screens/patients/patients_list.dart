import "package:flutter/material.dart";
import "./patient_card.dart";
import "../../models/user.dart";

class PatientsList extends StatelessWidget {
  final List<User> patients;
  const PatientsList({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children:
          patients.map((p) => PatientCard(patient: p as dynamic)).toList(),
    );
  }
}
