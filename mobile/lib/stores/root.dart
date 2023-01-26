import "package:flutter/material.dart";
import 'package:mobx/mobx.dart';
import '../screens/exercises/exercises.dart';
import '../screens/patients/patients.dart';
import '../screens/programs/programs.dart';
import '../screens/settings/settings.dart';
part 'root.g.dart';

enum Screen {
  patients,
  exercises,
  programs,
  settings,
}

class RootStore = _Root with _$RootStore;

abstract class _Root with Store {
  final List<Widget> _screens = [
    const Patients(),
    const Exercises(),
    const Programs(),
    Settings()
  ];

  final List<Widget?> _floatingActionButtons = [
    FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {},
    ),
    FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
    FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
    null,
  ];

  @observable
  int screenIdx = 0;

  @computed
  Widget get screen => _screens[screenIdx];

  @computed
  get floatingActionButton => _floatingActionButtons[screenIdx];

  @action
  void setScreen(int idx) {
    screenIdx = idx;
  }
}
