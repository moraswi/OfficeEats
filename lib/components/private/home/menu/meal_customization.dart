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
  int quantity = 1;
  int foodId = 0;
  double totalItemsAmount = 0;
  double unitPrice = 0;
  String? selectedOption;
  String? menuItemName;
  // Map<int, String?> selectedOptions = {};
  String? description;
  int getStoreId = 0;
  String? getShopName;
  String selectedOptionName = '';
  Map<int, int?> selectedOptions = {}; // Stores selected option ID for each title
  Map<int, double> selectedOptionPrices = {};

  @override
  void initState() {
    super.initState();

    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    // Perform all async operations before calling setState
    final fetchedFoodId = prefs.getInt('foodId') ?? 0;
    final fetchedTotalItemsAmount = prefs.getDouble('menuItemPrice') ?? 0.0;
    final fetchedMenuItemName = prefs.getString('menuItemName') ?? "";
    final fetchedDescription = prefs.getString('description') ?? "";
    getStoreId = prefs.getInt('storeId') ?? 0;
    getShopName = prefs.getString('shopName') ?? "";

    setState(() {
      // Update state synchronously
      foodId = fetchedFoodId;
      unitPrice = fetchedTotalItemsAmount;
      totalItemsAmount = unitPrice;
      menuItemName = fetchedMenuItemName;
      description = fetchedDescription;
    });

    getQuestionnaireTitleReq();
  }

  // getQuestionnaireTitleReq
  Future<void> getQuestionnaireTitleReq() async {
    try {
      List<dynamic> response =
          await storeService.getQuestionnaireTitleReq(foodId);

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

  // _increment
  void _increment() async {
    setState(() {
      quantity++;
      totalItemsAmount = unitPrice * quantity;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalItemsAmount = unitPrice * quantity;
      });
    }
  }

  // AddToCart
  void AddToCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cartItems') ?? [];

    // Prepare selected customizations
    List<Map<String, dynamic>> selectedCustomizations = selectedOptions.entries
        .map((entry) => {
              'titleId': entry.key,
              'optionName': selectedOptionName,
            })
        .toList();
    // prefs.setStringList('cartItems', []);
    // Check for duplicates
    bool isDuplicate = cartItems.any((item) {
      Map<String, dynamic> decodedItem = json.decode(item);

      // Check if foodId matches
      if (decodedItem['foodId'] != foodId) {
        return false;
      }

      // Check if all titleIds in customizations match
      List customizations = decodedItem['customizations'];
      if (customizations.length != selectedCustomizations.length) {
        return false;
      }

      for (var customization in selectedCustomizations) {
        if (!customizations.any((c) =>
            c['titleId'] == customization['titleId'] &&
            c['optionName'] == customization['optionName'])) {
          return false;
        }
      }

      return true;
    });

    if (isDuplicate) {
      print("Duplicate item not added to cart");
      return; // Exit if duplicate found
    }

    // Add the item as a JSON string
    cartItems.add(json.encode({
      'foodId': foodId,
      'foodName': menuItemName,
      'description': description,
      'itemPrice': totalItemsAmount,
      'quantity': quantity,
      'customizations': selectedCustomizations,
      'storeId':getStoreId,
      'storeName':getShopName,
    }));

    // Save updated cart
    prefs.setStringList('cartItems', cartItems);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/cart', (Route<dynamic> route) => true);

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
          padding: EdgeInsets.fromLTRB(10, 15, 10, 8),
          child: Column(
            children: [
              const Text(
                'Lorem Ipsum es simplemente el texto de'
                ' relleno de las imprentas y archivos'
                ' de texto. Lorem Ipsum ha sido el texto'
                ' de relleno estándar de las industrias desde'
                ' el año 1500, cuando un impresor (N. del T. persona que se dedica',
                style: TextStyle(fontSize: 15),
              ),

              isLoading
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5, // Number of skeletons
                      itemBuilder: (context, index) {
                        return SkeletonLoader();
                      },
                    )
                  : ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: titles.map((item) {
                  List<dynamic> options = item['options'];
                  int titleId = item['id'];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title text
                          Text(
                            item['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          // Options for this title
                          Column(
                            children: options.map((option) {
                              int optionId = option['id'];
                              selectedOptionName = option['name'];
                              double optionPrice = option['price'] ?? 0; // Price of the option

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Radio<int>(
                                            value: optionId,
                                            groupValue: selectedOptions[titleId],
                                            onChanged: (value) {
                                              setState(() {
                                                if (selectedOptions[titleId] != null) {
                                                  unitPrice -= selectedOptionPrices[titleId] ?? 0.0;
                                                }

                                                selectedOptions[titleId] = value;
                                                selectedOptionPrices[titleId] = option['price'].toDouble();

                                                // Add the new option's price
                                                unitPrice += option['price'].toDouble();

                                                totalItemsAmount = unitPrice * quantity;

                                              });
                                            },
                                          ),
                                          Text(
                                            option['name'] ?? 'loading...',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),

                                      // Price for the option
                                      Text(
                                        'R ${optionPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Divider between options (optional)
                                  if (options.indexOf(option) != options.length - 1)
                                    const Divider(),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              Container(
                height: 7,
                margin: EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: AppColors.tertiaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Text('R $totalItemsAmount',
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
                onTap: () async {
                  AddToCart();
                  // final prefs = await SharedPreferences.getInstance();
                  // List<String> cartItems = prefs.getStringList('cartItems') ?? [];
                  //
                  // prefs.setStringList('cartItems', cartItems);
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
