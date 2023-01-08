import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import "../../widgets/bottom_navigation.dart";

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Patients")),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
