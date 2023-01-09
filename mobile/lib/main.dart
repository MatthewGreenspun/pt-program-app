import 'package:flutter/material.dart';
import 'screens/login/login.dart';
import 'screens/patients/patients.dart';
import "package:shared_preferences/shared_preferences.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences
      .getInstance(); //TODO change shared preferences to secure storage
  String? loginId = prefs.getString("login_id");
  runApp(MyApp(loginId: loginId));
}

class MyApp extends StatelessWidget {
  String? loginId;
  MyApp({super.key, required this.loginId});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PT Program',
      theme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.lightBlue, secondary: Colors.lightBlueAccent)),
      home: loginId == null ? const Login() : const Patients(),
      routes: {"/patients": (context) => const Patients()},
    );
  }
}
