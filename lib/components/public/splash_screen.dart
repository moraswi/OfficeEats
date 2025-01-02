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
            Image.asset(
              'assets/images/motorbike2.png',

              height: 150,
            ),
            SizedBox(height: 15,),
            const Text(
              'Office Eats',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            )

          ],
        ),
      ),
    );
  }
}
