import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var newScreen;
  String role = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSharedPreferenceData();
    });
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedRole = prefs.getString('role');

    if (storedRole != null && storedRole.isNotEmpty) {
      role = storedRole;
    } else {
      role = "";
    }

    // Delayed navigation based on role
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(

          // role == "deliverypartner" ? '/deliveryorder' : '/office',
          role == "deliverypartner" ? '/deliveryorder' : '/townshop',
          (Route<dynamic> route) => true,
        );
      }
    });
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
            SizedBox(
              height: 15,
            ),
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
