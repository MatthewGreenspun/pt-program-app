import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import "../stores/root.dart";
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
  @override
  Widget build(BuildContext context) {
    return Consumer<RootStore>(
        builder: (_, rootStore, __) => Observer(
            builder: (_) => SafeArea(
                top: true,
                bottom: false,
                child: Scaffold(
                  appBar: rootStore.isLoading
                      ? const PreferredSize(
                          preferredSize: Size.fromHeight(5),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                          ))
                      : null,
                  body: PageView(
                    controller: rootStore.pageController,
                    onPageChanged: (idx) => rootStore.setScreenIdx(idx),
                    children: rootStore.screens,
                  ),
                  bottomNavigationBar: BottomNavigation(
                    idx: rootStore.screenIdx,
                    onTap: (idx) {
                      rootStore.changeScreen(idx);
                    },
                  ),
                  floatingActionButton: rootStore.floatingActionButton,
                ))));
  }
}
