import "../models/settings.dart";
import "../services/settings.service.dart";
import "package:flutter/material.dart";
import 'package:mobx/mobx.dart';
part 'settings.g.dart';

class SettingsStore extends _Settings with _$SettingsStore {
  SettingsStore(SettingsService settingsService) : super(settingsService);
}

abstract class _Settings with Store {
  SettingsService settingsService;
  _Settings(this.settingsService);

  @observable
  Unit units = Unit.imperial;

  @action
  void setUnits(Unit value) {
    units = value;
    settingsService.setUnits(value);
  }

  @observable
  AccountType accountType = AccountType.doctor;

  @action
  void setAccountType(AccountType value) {
    accountType = value;
  }

  @observable
  bool isDark = true;

  @action
  void setIsDark(bool value) {
    isDark = value;
    settingsService.setIsDark(value);
  }

  @observable
  MaterialColor primaryColor = Colors.blue;

  @action
  void setPrimaryColor(MaterialColor value) {
    primaryColor = value;
    settingsService.setPrimaryColor(value);
  }

  @observable
  String joinCode = "";

  @action
  void setJoinCode(String value) {
    joinCode = value;
  }

  @action
  Future<void> readSavedSettings() async {
    final savedIsDark = await settingsService.isDark;
    final savedPrimaryColor = await settingsService.primaryColor;
    final savedUnits = await settingsService.units;
    final user = await settingsService.user;
    if (user['joinCode'] != null) {
      setJoinCode(user['joinCode']);
    }
    setIsDark(savedIsDark);
    setPrimaryColor(savedPrimaryColor);
    setUnits(savedUnits);
  }
}
