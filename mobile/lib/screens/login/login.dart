import 'package:flutter/material.dart';
import './login_field.dart';
import "package:shared_preferences/shared_preferences.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _codeController;
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Route _animationRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Center(
          child: Scaffold(
              body: Center(
                  child: Container(
                      width: 500,
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "A code has been sent to ${_emailController.value.text}", //TODO doesn't look good
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20, ),
                          ),
                          LoginField(
                            controller: _codeController,
                            label: "Code",
                            inputType: TextInputType.number,
                          ),
                          ElevatedButton(
                            onPressed: onCodeSubmit,
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromHeight(
                                    40)), //TODO responsive
                            child: const Text("Submit"),
                          ),
                        ],
                      ))))),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void onEmailSubmit() {
    Navigator.of(context).push(_animationRoute());
  }

  void onCodeSubmit() {
    //TODO:
    SharedPreferences.getInstance().then((instance) => instance.setString(
        "login_id",
        "some login id")); // TODO store some server generated id after login
    Navigator.pushNamedAndRemoveUntil(context, "/patients", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              //TODO add logo
              width: 500, //TODO responsive
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginField(
                    controller: _emailController,
                    label: "Email",
                    inputType: TextInputType.emailAddress,
                  ),
                  LoginField(
                    controller: _passwordController,
                    label: "Password",
                    isPassword: true,
                  ),
                  ElevatedButton(
                    onPressed: onEmailSubmit,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(40)), //TODO responsive
                    child: const Text("Submit"),
                  ),
                ],
              ))),
    );
  }
}
