import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:mobx/mobx.dart';
import "../screens/login/login.dart";
part 'root.g.dart';

enum Screen {
  login,
  home,
  patients,
  exercises,
  programs,
  settings,
}

class Root = _Root with _$Root;

abstract class _Root with Store {
  @observable
  Screen screen = Screen.login;

  @action
  void changeScreen({required Screen screen}) {
    this.screen = screen;
  }
}
