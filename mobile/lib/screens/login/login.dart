import 'package:flutter/material.dart';
import 'package:mobile/services/auth.service.dart';
import 'package:mobile/widgets/styled_text.dart';
import './login_field.dart';
import "../patients/patients.dart";
import "../../stores/root.dart";
import "../../widgets/search_bar.dart";
import "package:shared_preferences/shared_preferences.dart";

final Root rootStore = Root();

class Login extends StatefulWidget {
  static const String routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _codeController; //TODO add verification email
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final authService = AuthService();

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

  // TODO Add verification email
  // Route _animationRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Center(
  //         child: Scaffold(
  //             body: Center(
  //                 child: Container(
  //                     width: 500,
  //                     padding: const EdgeInsets.only(top: 100),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.stretch,
  //                       children: [
  //                         Text(
  //                           "A code has been sent to ${_emailController.value.text}",
  //                           textAlign: TextAlign.center,
  //                           style: const TextStyle(
  //                             fontSize: 20,
  //                           ),
  //                         ),
  //                         LoginField(
  //                           controller: _codeController,
  //                           label: "Code",
  //                           inputType: TextInputType.number,
  //                         ),
  //                         ElevatedButton(
  //                           onPressed: onCodeSubmit,
  //                           style: ElevatedButton.styleFrom(
  //                               fixedSize: const Size.fromHeight(
  //                                   40)), //TODO responsive
  //                           child: const Text("Submit"),
  //                         ),
  //                       ],
  //                     ))))),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.easeInOut;
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  void onEmailSubmit(BuildContext context) {
    //TODO:
    if (_formKey.currentState!.validate()) {
      // rootStore.changeScreen(screen: Screen.patients);
      authService
          .login(_emailController.value.text, _passwordController.value.text)
          .then((_) {
        Navigator.pushNamedAndRemoveUntil(context, "/root", (route) => false);
      }).catchError((error, stacktrace) {
        print(error);
        print(stacktrace);
        const snackBar = SnackBar(
          content: StyledText(
            'Authentication Failed',
            textAlign: TextAlign.center,
            size: 20,
            bold: true,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 128, 28, 21),
          duration: Duration(seconds: 5),
          width: 300,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          body: Center(
              child: Container(
                  //TODO use form widget
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
                        onPressed: () {
                          onEmailSubmit(context);
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                const Size.fromHeight(40)), //TODO responsive
                        child: const Text("Submit"),
                      ),
                    ],
                  ))),
        ));
  }
}
