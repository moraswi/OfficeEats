import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  var routeName = '/cart';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  // loadCartItems
  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();

    // cartItemsData
    List<String> cartItemsData = prefs.getStringList('cartItems') ?? [];

    setState(() {
      cartItems = cartItemsData
          .map((item) => json.decode(item))
          .toList()
          .cast<Map<String, dynamic>>();
    });
  }

  // _saveCartItems
  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    // cartItemsData
    List<String> cartItemsData =
        cartItems.map((item) => json.encode(item)).toList();
    await prefs.setStringList('cartItems', cartItemsData);
  }

  // _removeItem
  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });

    _saveCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Column(
                    children: [
                      MenuItem(
                        // imagePath:
                        //     item['imagePath'] ?? 'assets/images/burgermeal.png',
                        name: item['foodName'] ?? 'Loading...',
                        description: item['description'] ?? '',
                        price: item['itemPrice'] ?? 0.0,
                        // name: "item['foodName'] ?? 'Loading...'",
                        // description: "item['description'] ?? 0.0",
                        // price: 0.0,
                        onDelete: () => _removeItem(index),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            CustomButton(
              label: 'Check Out',
              onTap: () {
                if (cartItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Your cart is empty!'),
                  ));
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/orderreview', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}

// MenuItem
class MenuItem extends StatelessWidget {
  // final String imagePath;
  final String name;
  final String description;
  final double price;
  final VoidCallback onDelete;

  MenuItem({
    // required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image.asset(
          //   imagePath,
          //   width: 80,
          //   height: 80,
          //   fit: BoxFit.cover,
          // ),
          // SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${description}', style: TextStyle(fontSize: 16)),
                Text(
                  '\R${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
