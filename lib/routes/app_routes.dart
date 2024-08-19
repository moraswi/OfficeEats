// routes.dart

import 'package:flutter/material.dart';
import 'package:eats/public/forgot_password.dart';
import 'package:eats/public/landing_page.dart';
import 'package:eats/public/logIn.dart';
import 'package:eats/public/reset_password.dart';
import 'package:eats/public/sign_up.dart';
import 'package:eats/public/splash_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/': (context) => ContainSelector(),
    LogIn().routeName: (context) => LogIn(),
    SignUp().routeName: (context) => SignUp(),
    LandingPage().routeName: (context) => LandingPage(),
    ForgotPassword().routeName: (context) => ForgotPassword(),
    ResetPassword().routeName: (context) => ResetPassword(),
  };
}

class ContainSelector extends StatefulWidget {
  const ContainSelector({Key? key}) : super(key: key);

  @override
  _ContainSelectorState createState() => _ContainSelectorState();
}

class _ContainSelectorState extends State<ContainSelector> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
