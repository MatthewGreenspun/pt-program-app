import "package:flutter/material.dart";
import 'package:mobile/screens/program_builder/program_builder.dart';
import 'package:mobile/stores/index.dart';
import 'package:mobile/widgets/index.dart';
import 'package:provider/provider.dart';
import "../../models/patient.dart";

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    void onDelete(RootStore rootStore, PatientsStore patientsStore) {
      rootStore.setIsLoading(true);
      patientsStore
          .deletePatient(patient.id)
          .then((value) => rootStore.setIsLoading(false));
    }

    return Consumer3<RootStore, PatientsStore, ProgramsStore>(
        builder: (_, rootStore, patientsStore, programsStore, __) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: StyledText(patient.name, size: 30)),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: rootStore.isLoading
                                      ? null
                                      : () {
                                          onDelete(rootStore, patientsStore);
                                        },
                                  icon: const Icon(Icons.delete))
                            ],
                          )
                        ]),
                    const StyledText("Programs", size: 20),
                    ...patient.programNames
                        .asMap()
                        .entries
                        .map((entry) => ElevatedButton.icon(
                              onPressed: () async {
                                rootStore.setIsLoading(true);
                                final programId = patient.programIds[entry.key];
                                programsStore.addProgram(programId).then((_) {
                                  rootStore.setIsLoading(false);
                                  rootStore.changeScreen(Screen.programs.index,
                                      animate: true);
                                });
                              },
                              icon: const Icon(Icons.view_list),
                              label: Text("${patient.name} - ${entry.value}"),
                            ))
                        .toList(),
                    OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, ProgramBuilder.routeName,
                              arguments: patient.id);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add New"))
                  ],
                ))));
  }
}
