import 'package:flutter/material.dart';

import '../menu_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Delivery App'),
        ),
        body: MenuPage(),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {

  var routeName = '/storemenu';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool showCheckoutButton = false;

  void _toggleCheckoutButton() {
    setState(() {
      showCheckoutButton = !showCheckoutButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              MenuItem(
                imagePath: 'assets/images/food1.jpg',
                name: 'Food Item 1',
                rating: 4.5,
                price: 12.99,
              ),
              MenuItem(
                imagePath: 'assets/images/food2.jpg',
                name: 'Food Item 2',
                rating: 4.0,
                price: 10.99,
              ),
              // Add more MenuItem widgets here
            ],
          ),
        ),

      ],
    );
  }
}
