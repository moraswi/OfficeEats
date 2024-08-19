import 'dart:async';
import 'package:flutter/material.dart';

import 'home_screen_widget/StoreCard.dart';
import 'home_screen_widget/TopBar.dart';

class HomeScreen extends StatefulWidget {
  var routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100,),
          TopBar(),
          SizedBox(height: 20,),

          StoreCard(),
        ],
      ),
    );
  }
}
