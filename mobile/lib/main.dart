import 'package:flutter/material.dart';
import 'screens/login/login.dart';

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
                primary: Colors.yellow, secondary: Colors.yellowAccent)),
        home: const Login());
  }
}
