import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import "../../widgets/bottom_navigation.dart";
import "./patients_list.dart";
import "../../models/user.dart";

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            decoration: InputDecoration(label: Text("Search")),
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: PatientsList(patients: [
            User("", "Matthew", UserType.patient,
                "test@test.com"), //TODO fetch from backend
            User("", "Matthew", UserType.patient, "test@test.com"),
            User("", "Matthew", UserType.patient, "test@test.com"),
            User("", "Matthew", UserType.patient, "test@test.com"),
            User("", "Matthew", UserType.patient, "test@test.com"),
            User("", "Matthew", UserType.patient, "test@test.com"),
          ])),
      bottomNavigationBar: const BottomNavigation(),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
