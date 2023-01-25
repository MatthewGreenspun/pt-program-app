import 'package:flutter/material.dart';
import 'package:mobile/services/auth.service.dart';
import 'package:mobile/widgets/root_container.dart';
import 'package:mobile/widgets/styled_text.dart';
import './login_field.dart';

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

  bool _isFetching = false;

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
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isFetching = true;
      });
      authService
          .login(_emailController.value.text, _passwordController.value.text)
          .then((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, RootContainer.routeName, (route) => false);
      }).catchError((error, stacktrace) {
        final snackBar = SnackBar(
          content: StyledText(
            '$error',
            textAlign: TextAlign.center,
            size: 20,
            bold: true,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 166, 24, 14),
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).whenComplete(() {
        setState(() {
          _isFetching = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: Scaffold(
          appBar: _isFetching
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(5),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                  ))
              : null,
          body: Center(
              child: SizedBox(
                  width: 500, //TODO responsive
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(50),
                          child: Image.asset(
                            "assets/icons/horizontal_transparent.png",
                            width: 150,
                            height: 150,
                          )),
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
                        onPressed: _isFetching
                            ? null
                            : () {
                                onEmailSubmit(context);
                              },
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                const Size.fromHeight(40)), //TODO responsive
                        child: const Text("Login"),
                      ),
                    ],
                  )))),
    ));
  }
}
