import "package:shared_preferences/shared_preferences.dart";
import "../models/settings.dart";
import "package:flutter/material.dart";
import './base.service.dart';

class SettingsService extends BaseService {
  SettingsService() : super();

  Future<bool> get isDark async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDark") ?? true;
  }

  Future<void> setIsDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", value);
  }

  Future<MaterialColor> get primaryColor async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString("primaryColor");
    switch (color) {
      case "red":
        return Colors.red;
      case "amber":
        return Colors.amber;
      case "yellow":
        return Colors.yellow;
      case "green":
        return Colors.green;
      case "blue":
        return Colors.blue;
      case "purple":
        return Colors.purple;
      case "pink":
        return Colors.pink;
      default:
        return Colors.blue;
    }
  }

  Future<void> setPrimaryColor(MaterialColor value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("primaryColor", _colorToString(value));
  }

  String _colorToString(MaterialColor color) {
    if (color.value == Colors.red.value) {
      return "red";
    } else if (color.value == Colors.amber.value) {
      return "amber";
    } else if (color.value == Colors.yellow.value) {
      return "yellow";
    } else if (color.value == Colors.green.value) {
      return "green";
    } else if (color.value == Colors.blue.value) {
      return "blue";
    } else if (color.value == Colors.purple.value) {
      return "purple";
    } else if (color.value == Colors.pink.value) {
      return "pink";
    } else {
      return "blue";
    }
  }

  // Future<AccountType> get accountType async { //TODO server
  // }

  Future<Map> get user async {
    return await request(
        "/users/doctor/08faac06-aaec-4f0a-94b6-89442ed9ac7d", Method.get);
  }

  Future<Unit> get units async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("units") == "metric" ? Unit.metric : Unit.imperial;
  }

  Future<void> setUnits(Unit value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("units", value == Unit.metric ? "metric" : "imperial");
  }
}
