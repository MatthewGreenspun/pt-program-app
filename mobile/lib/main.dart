import 'package:flutter/material.dart';
import 'screens/login/login.dart';
import 'screens/patients/patients.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PT Program',
      theme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.lightBlue, secondary: Colors.lightBlueAccent)),
      home: const Login(),
      routes: {"/patients": (context) => const Patients()},
    );
  }
}
