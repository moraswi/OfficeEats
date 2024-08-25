import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/utilils/app_colors.dart';

class LandingPage extends StatefulWidget {
  var routeName = '/landingPage';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
        decoration: BoxDecoration(),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Office Eats',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Welcome to Office Eats! Enjoy delicious meals delivered or ready for pickup, Simplify order with our tailored service!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Align buttons in the center
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.fromLTRB(40, 14, 40, 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/signUp', (Route<dynamic> route) => true);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  ),
                ),
                SizedBox(width: 16), // Space between the buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    padding: EdgeInsets.fromLTRB(50, 14, 50, 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/logIn', (Route<dynamic> route) => true);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
