import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import "../stores/root.dart";
import "../screens/login/login.dart";
import "../screens/patients/patients.dart";
import "../screens/exercises/exercises.dart";
import "../screens/programs/programs.dart";
import "../screens/settings/settings.dart";
import "./bottom_navigation.dart";

class RootContainer extends StatefulWidget {
  static const String routeName = '/root-container';
  const RootContainer({super.key});

  @override
  State<RootContainer> createState() => _RootContainerState();
}

class _RootContainerState extends State<RootContainer> {
  final List<Widget> _pages = [
    const Patients(),
    const Exercises(),
    const Programs(),
    Settings()
  ];
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigation(
        idx: _idx,
        onTap: (value) {
          setState(() {
            _idx = value;
          });
        },
      ),
    );
  }
}
