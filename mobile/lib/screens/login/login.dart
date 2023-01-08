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
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Text(
                            "A code has been sent to ${_emailController.value.text}", //TODO doesn't look good
                            style: const TextStyle(fontSize: 30),
                          ),
                          LoginField(
                            controller: _codeController,
                            label: "Code",
                            inputType: TextInputType.number,
                          ),
                          ElevatedButton(
                            onPressed: onCodeSubmit,
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromWidth(
                                    500)), //TODO responsive
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
    Navigator.popAndPushNamed(context, "/patients");
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
                        fixedSize: const Size.fromWidth(500)), //TODO responsive
                    child: const Text("Submit"),
                  ),
                ],
              ))),
    );
  }
}
