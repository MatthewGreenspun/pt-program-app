import "package:flutter/material.dart";
import "../../models/user.dart";

class PatientCard extends StatelessWidget {
  final User patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(children: [
              Flexible(
                  child: ListTile(
                title: Text(patient.name),
                leading: const Icon(Icons.person),
              )),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Manage"),
              )
            ])));
  }
}
