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
  List<dynamic> titles = [];
  bool isLoading = true;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    getQuestionnaireTitleReq();
    // getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    setState(() {});
  }

  // getOrdersReq
  Future<void> getQuestionnaireTitleReq() async {
    try {
      print('response////////////////////////');

      List<dynamic> response = await storeService.getQuestionnaireTitleReq(2);
      print('response////////////////////////');
      print(response);
      print('response////////////////////////');

      setState(() {
        titles = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            children: [
              ...titles.map((item) {
                List<dynamic> options = item['options'] ?? [];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      // color: AppColors.tertiaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // titles

                        Container(
                          height: 9,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryColor,
                          ),
                        ),

                        Text(
                          item['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        Column(
                          children: options.asMap().entries.map((entry) {
                            final index = entry.key;
                            final option = entry.value;

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: option['name'],
                                          groupValue: null, // Replace with selected value state
                                          onChanged: (value) {
                                            // Handle selection
                                          },
                                        ),
                                        Text(
                                          option['name'] ?? 'Option Name',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'R ${option['price'] ?? 0.0}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                if (index != options.length - 1 ) Divider(),
                              ],
                            );
                          }).toList(),
                        )



                      ],
                    ),
                  ),
                );
              }).toList(),



              Container(
                height: 7,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryColor,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Text('R120.02',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18))
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              // Quantity
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Quantity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
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

                const SizedBox(
                  height: 10,
                ),
              CustomButton(
                label: 'Add to Cart',
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}
