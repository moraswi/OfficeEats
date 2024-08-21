import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import '../../../../core/utilils/app_colors.dart';
import '../../../shared/app_buttons.dart';

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
                  style: const TextStyle(
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  var routeName = '/cart';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                  '/history', (Route<dynamic> route) => true);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  MenuItem(
                    imagePath: 'assets/images/image1.webp',
                    name: 'Food Item 1',
                    rating: 4.5,
                    price: 12.99,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food2.jpeg',
                    name: 'Food Item 1',
                    rating: 4.5,
                    price: 12.99,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    label: 'Pay',
                    onTap: () {
                      // Handle button press
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => true);
                    },
                  ),
                ],
              ),
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
