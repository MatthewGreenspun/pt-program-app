import "package:flutter/material.dart";
import "../../models/user.dart";

class PatientCard extends StatelessWidget {
  final User patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(
      title: Text(patient.name),
      leading: const Icon(Icons.person),
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("Add Program"))
      ],
    ));
  }
}
