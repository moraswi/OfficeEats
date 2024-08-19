import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var newScreen;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/landingPage',
              (Route<dynamic> route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Office Eats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            )
            // Image.asset(
            //   'assets/legacyLogo.png',
            //   width: 200,
            //   height: 200,
            // ),
          ],
        ),
      ),
    );
  }
}
