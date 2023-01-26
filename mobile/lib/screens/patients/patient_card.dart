import "package:flutter/material.dart";
import 'package:mobile/widgets/index.dart';
import "../../models/patient.dart";

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(patient.name, size: 35),
                const StyledText("Programs", size: 25),
                ...patient.programNames
                    .asMap()
                    .entries
                    .map((entry) => ElevatedButton.icon(
                          onPressed: () {}, //TODO add program to programs page
                          icon: const Icon(Icons.view_list),
                          label: Text("${patient.name} - ${entry.value}"),
                        ))
                    .toList(),
                OutlinedButton.icon(
                    onPressed: () {}, //TODO open program builder
                    icon: const Icon(Icons.add),
                    label: const Text("Add New"))
              ],
            )));
  }
}
