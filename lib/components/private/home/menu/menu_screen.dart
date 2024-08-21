import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import '../menu/top_bar.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String name;
  final double rating;
  final double price;

  MenuItem({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.price,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int quantity = 0;

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            widget.imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${widget.rating}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Text(
                  '\R${widget.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.red),
                    onPressed: _decrement,
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: _increment,
                  ),
                ],
              ),
            ],
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 105,),
          TopBar(),

          Expanded(
            child: ListView(
              children: [
                MenuItem(
                  imagePath: 'assets/images/image1.webp',
                  name: 'Food Item 1',
                  rating: 4.5,
                  price: 12.99,
                ),

                MenuItem(
                  imagePath: 'assets/images/food2.jpeg',
                  name: 'Food Item 1',
                  rating: 4.5,
                  price: 12.99,
                ),
                MenuItem(
                  imagePath: 'assets/images/food3.jpeg',
                  name: 'Food Item 2',
                  rating: 4.0,
                  price: 10.99,
                ),
                MenuItem(
                  imagePath: 'assets/images/food4.jpeg',
                  name: 'Food Item 2',
                  rating: 4.0,
                  price: 10.99,
                ),
                MenuItem(
                  imagePath: 'assets/images/food5.jpeg',
                  name: 'Food Item 2',
                  rating: 4.0,
                  price: 10.99,
                ),
                MenuItem(
                  imagePath: 'assets/images/food6.jpeg',
                  name: 'Food Item 2',
                  rating: 4.0,
                  price: 10.99,
                ),
                MenuItem(
                  imagePath: 'assets/images/food7.jpeg',
                  name: 'Food Item 2',
                  rating: 4.0,
                  price: 10.99,
                ),

                MenuItem(
                  imagePath: 'assets/images/food9.jpeg',
                  name: 'Food Item 2',
                  rating: 4.0,
                  price: 10.99,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}
