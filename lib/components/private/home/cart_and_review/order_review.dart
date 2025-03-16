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
  List<Map<String, dynamic>> orderCustomerzation = [];

  var getAddress;
  String getOfficeName = "";
  String getOfficeLocation = "";
  String getFirstName = "";
  String getSurname = "";
  String getPhoneNumber = "";
  String getOfficeAddress = "";

  int getUserId = 0;
  int getOfficeId = 0;

  String paymentMethod = "Cash";
  int getStoreId = 0;
  String getShopName = "N/A";

  String _selectedOption = 'delivery';

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

      getOfficeId = prefs.getInt('officeId') ?? 0;
      getUserId = prefs.getInt('userId') ?? 0;
      getStoreId = prefs.getInt('storeId') ?? 0;
      getShopName = prefs.getString('shopName') ?? "";
    });

    getUserAddressReq();
  }

  Future<void> submitOrder() async {
    String description = orderInstructionController.text;

    if (getOfficeAddress == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add your office address')),
      );
      return;
    }

    try {
      await storeService.placeOrderReq(
          context,
          getUserId,
          getOfficeAddress,
          paymentMethod,
          getStoreId,
          getShopName,
          getUserId,
          description,
          orderItems);
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
                    'Delivery Address',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$getOfficeAddress',
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
                  const SizedBox(
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
            const SizedBox(height: 20),

            ListTile(
              title: Text('Delivery: R75.00'),
              leading: Radio<String>(
                value: 'delivery',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Collection R0.00'),
              leading: Radio<String>(
                value: 'collection',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected option: ${_selectedOption == 'delivery' ? 'Delivery (R75.00)' : 'Collection (R0.00)'}',
              style: TextStyle(fontSize: 16),
            ),

            const Text(
              'To pay for this order, send cash to our store. Find our bank details under History > Track Order.',
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
