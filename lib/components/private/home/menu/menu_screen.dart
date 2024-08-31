import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import '../../../../shared/app_colors.dart';
import '../../../../shared/app_buttons.dart';
import '../menu/top_bar.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String name;
  final double rating;
  final double price;
  final Function(int) onQuantityChanged; // Callback to notify parent

  MenuItem({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.price,
    required this.onQuantityChanged,
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
    widget.onQuantityChanged(quantity); // Notify parent
  }

  void _decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
      widget.onQuantityChanged(quantity); // Notify parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
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
              Text('Hot Deal', style: TextStyle(color: AppColors.primaryColor)),
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
  int _totalQuantity = 0;

  void _updateTotalQuantity(int quantity) {
    setState(() {
      _totalQuantity += quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_sharp,
                size: 28, color: AppColors.primaryColor),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/cart', (Route<dynamic> route) => true);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: [
            TopBar(),
            Expanded(
              child: ListView(
                children: [
                  MenuItem(
                    imagePath: 'assets/images/image1.webp',
                    name: 'Food Item 1',
                    rating: 4.5,
                    price: 12.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food2.jpeg',
                    name: 'Food Item 1',
                    rating: 4.5,
                    price: 12.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food3.jpeg',
                    name: 'Food Item 2',
                    rating: 4.0,
                    price: 10.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food4.jpeg',
                    name: 'Food Item 2',
                    rating: 4.0,
                    price: 10.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food5.jpeg',
                    name: 'Food Item 2',
                    rating: 4.0,
                    price: 10.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food6.jpeg',
                    name: 'Food Item 2',
                    rating: 4.0,
                    price: 10.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food7.jpeg',
                    name: 'Food Item 2',
                    rating: 4.0,
                    price: 10.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food9.jpeg',
                    name: 'Food Item 2',
                    rating: 4.0,
                    price: 10.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              label: 'My Cart',
              onTap: () {
                // Handle button press
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/cart', (Route<dynamic> route) => true);
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
