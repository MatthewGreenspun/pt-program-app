import "package:flutter/material.dart";
import "../../models/user.dart";

class PatientCard extends StatelessWidget {
  final User patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(patient.name),
        const Text("No Weight"),
        const Text("3 sets of 10")
      ]),
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
        activeColor: Theme.of(context).colorScheme.primary,
      ),
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("Add Program"))
      ],
    ));
  }
}
