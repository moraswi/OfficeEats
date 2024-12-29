import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/bottom_nav_bar.dart';

import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/app_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../http/authApiService.dart';

class OrderReviewPage extends StatefulWidget {
  var routeName = '/orderreview';

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  final StoreApiService storeService = StoreApiService();
  final AuthApiService authService = AuthApiService();

  TextEditingController orderInstructionController = TextEditingController();

  List<Map<String, dynamic>> orderItems = [];

  var getAddress;
  String getOfficeName = "";
  String getOfficeLocation = "";
  String getFirstName = "";
  String getSurname = "";
  String getPhoneNumber = "";
  String getOfficeAddress = "";

  int getUserId = 0;
  String paymentMethod = "Cash";
  int getStoreId = 0;
  String getShopName = "N/A";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      List<String> cartItemsData = prefs.getStringList('cartItems') ?? [];

      orderItems = cartItemsData
          .map((item) => json.decode(item))
          .toList()
          .cast<Map<String, dynamic>>();

      getOfficeName = prefs.getString('officeName') ?? "";
      getOfficeLocation = prefs.getString('officeLocation') ?? "";
      getFirstName = prefs.getString('firstName') ?? "";
      getSurname = prefs.getString('lastName') ?? "";
      getPhoneNumber = prefs.getString('phoneNumber') ?? "";

      getUserId = prefs.getInt('userId') ?? 0;
      getStoreId = prefs.getInt('storeId') ?? 0;
      getShopName = prefs.getString('shopName') ?? "";
    });

    getUserAddressReq();
  }

  List<Map<String, dynamic>> consolidateQuantities(List<Map<String, dynamic>> items) {
    final Map<int, Map<String, dynamic>> consolidatedItems = {};

    for (final item in items) {
      final int foodId = item['foodId'];

      if (consolidatedItems.containsKey(foodId)) {
        // Increment the quantity for the existing foodId
        consolidatedItems[foodId]!['quantity'] += 1;
      } else {
        // Add the item with an initial quantity of 1
        consolidatedItems[foodId] = {
          ...item,
          'quantity': 1, // Reset quantity to count occurrences
        };
      }
    }

    // Convert the map back to a list
    return consolidatedItems.values.toList();
  }

  Future<void> submitOrder() async {
    String description = orderInstructionController.text;

    if (getOfficeAddress == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add your office address')),
      );

      return;
    }

    // Consolidate quantities in the order items
    final List<Map<String, dynamic>> consolidatedItems = consolidateQuantities(orderItems);

    try {
      await storeService.placeOrderReq(
        context,
        getUserId,
        getOfficeAddress,
        paymentMethod,
        getStoreId,
        getShopName,
        description,
        consolidatedItems,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Failed: $e')),
      );
    }
  }


  // getUserAddressReq
  Future<void> getUserAddressReq() async {
    try {
      Map<String, dynamic> response =
          await authService.getUserAddressReq(getUserId);
      setState(() {
        getAddress = [response];
        getOfficeAddress = getAddress[0]['officeAddress'] ?? 'N/A';

        print('Address Details: $getOfficeAddress');
      });
    } catch (e) {
      print(getAddress);
    }
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          children: [
            // const SizedBox(height: 120),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.tertiaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Office Address',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$getOfficeName, $getOfficeLocation',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    height: 2,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Text(
                    'Order Instruction',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  TextFormField(
                    controller: orderInstructionController,
                    decoration: InputDecoration(
                      hintText: 'Note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  // const Text(
                  //   'Call me when you are near my office',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    height: 2,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Text(
                    'My Details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$getFirstName $getSurname',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    getPhoneNumber,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Collect your food when the order status is complete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(8.0),
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
                    'assets/images/mastercard.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'mastercard',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Cash only at the moment.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              label: 'Submit Order',
              onTap: () {
                submitOrder();
                // Handle button press
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
