import "package:flutter/material.dart";
import 'package:mobx/mobx.dart';
import '../screens/exercises/exercises.dart';
import '../screens/patients/patients.dart';
import '../screens/programs/add_programs_button.dart';
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
  final List<Widget> screens = [
    const Patients(),
    const Exercises(),
    const Programs(),
    Settings()
  ];

  final List<Widget?> _floatingActionButtons = [
    const AddPatientsButton(),
    FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
    const AddProgramsButton(),
    null,
  ];

  late PageController pageController;

  _Root() : pageController = PageController();

  @observable
  int screenIdx = 0;

  @observable
  bool isLoading = false;

  @action
  setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  @computed
  Widget get screen => screens[screenIdx];

  @computed
  get floatingActionButton => _floatingActionButtons[screenIdx];

  @action
  setScreenIdx(int idx) {
    screenIdx = idx;
  }

  @action
  void changeScreen(int idx, {bool animate = false}) {
    setScreenIdx(idx);
    if (animate) {
      pageController.animateToPage(idx,
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    } else {
      pageController.jumpToPage(idx);
    }
  }
}
