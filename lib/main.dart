import 'package:eats/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      routes: getRoutes(),
    );
  }
}