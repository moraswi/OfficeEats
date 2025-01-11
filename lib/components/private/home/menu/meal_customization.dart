import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/skeleton_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart_and_review/cart_screen.dart';
import '../menu/top_bar.dart';

class MenuCustomization extends StatefulWidget {
  var routeName = '/menucustomization';

  @override
  _MenuCustomizationState createState() => _MenuCustomizationState();
}

class _MenuCustomizationState extends State<MenuCustomization> {
  int _totalQuantity = 0;

  final StoreApiService storeService = StoreApiService();
  List<dynamic> menus = [];

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    setState(() {
    });

  }

  int quantity = 0;

  void _increment() async {
    setState(() {
      quantity++;
    });

    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cartItems') ?? [];

    prefs.setStringList('cartItems', cartItems);
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(0))),
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(0)),
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/burgermeal.png"),
                      fit: BoxFit.fill)),
            ),
          ),
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
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: [

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  value: 'dipName',
                  groupValue: null, // Replace with your selected value state
                  onChanged: (value) {
                    // Handle selection change
                  },
                ),
                Text(
                  'dipName',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Text(
              'price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
            ),

            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: _decrement,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.all(3.0),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),

                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 30),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: _increment,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                    ),
                    padding: EdgeInsets.all(3.0),

                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),

Divider(),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              label: 'Add to Cart',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartPage()));
                // Handle button press
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     '/cart', (Route<dynamic> route) => true);
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

