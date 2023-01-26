import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/screens/patients/patient_card.dart';
import 'package:mobile/stores/index.dart';
import 'package:provider/provider.dart';

class Patients extends StatefulWidget {
  static const routeName = "/patients";
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientsStore>(
        builder: (_, patientsStore, __) => Observer(
            builder: (_) => patientsStore.patients.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: patientsStore.patients
                        .map((patient) => PatientCard(
                              patient: patient,
                            ))
                        .toList(),
                  )));
  }
}

class AddPatientsButton extends StatelessWidget {
  const AddPatientsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add));
  }
}
