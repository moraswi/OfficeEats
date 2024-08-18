import 'package:eats/private/ForgotPassword.dart';
import 'package:eats/private/LandingPage.dart';
import 'package:eats/private/LogIn.dart';
import 'package:eats/private/ResetPassword.dart';
import 'package:eats/private/SignUp.dart';
import 'package:eats/private/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        //public pages
        '/': (context) => ContainSelector(),
        LogIn().routeName: (context) => LogIn(),
        SignUp().routeName: (context) => SignUp(),
        LandingPage().routeName: (context) => LandingPage(),
        ForgotPassword().routeName: (context) => ForgotPassword(),
        ResetPassword().routeName: (context) => ResetPassword(),
      },
    );
  }
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
