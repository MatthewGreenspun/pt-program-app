import 'package:flutter/material.dart';
import './login_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onSubmit() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          LoginField(controller: _emailController, label: "Email"),
          LoginField(controller: _passwordController, label: "Password"),
          ElevatedButton(
              onPressed: onSubmit,
              child: const Text("Submit"),
              style: ElevatedButton.styleFrom(fixedSize: Size.fromWidth(500))),
        ],
      )),
    );
  }
}
