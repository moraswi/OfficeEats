import 'dart:io';

import 'package:eats/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
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