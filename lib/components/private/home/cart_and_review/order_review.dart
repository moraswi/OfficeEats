import 'package:flutter/material.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/bottom_nav_bar.dart';

import '../../../../http/storeApiService.dart';
import '../../../../shared/app_buttons.dart';

class OrderReviewPage extends StatefulWidget {
  var routeName = '/orderreview';

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  final StoreApiService storeService = StoreApiService();

  Future<void> submitOssrder() async {
    try {
      int userId = 0;
      String deliveryAddress = "ADDRESS HERE";
      String paymentMethod = "Cash";
      int shopId = 0;
      String orderCode = "ORD12345"; // Example order code
      String storeName = "My Store"; // Example store name

      final items = [
        {'foodId': 1, 'quantity': 2, 'itemPrice': 10.0},
        {'foodId': 2, 'quantity': 1, 'itemPrice': 5.5},
      ];

      // Define the list of items
      List<Map<String, dynamic>> itkems = [
        {
          'foodId': 1,
          'quantity': 2,
          'itemPrice': 10.0,
        },
        {
          'foodId': 2,
          'quantity': 1,
          'itemPrice': 20.0,
        },
      ];

      // Call the updated `placeOrderReq` function
      await storeService.placeOrderReq(
        context,
        userId,
        deliveryAddress,
        paymentMethod,
        shopId,
        orderCode,
        storeName,
        items,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Failed: $e')),
      );
    }
  }

  Future<void> submitOrder() async {
    final int userId = 0;
    final String deliveryAddress = "string";
    final String paymentMethod = "string";
    final int shopId = 0;
    final String orderCode = "string";
    final String storeName = "string";

    // Construct the items list
    final List<Map<String, dynamic>> items = [
      {
        "foodId": 1,
        "quantity": 2,
        "itemPrice": 5.5,
      },
      {
        "foodId": 2,
        "quantity": 1,
        "itemPrice": 9.0,
      },
    ];

    try {
      await storeService.placeOrderReq(
        context,
        userId,
        deliveryAddress,
        paymentMethod,
        shopId,
        orderCode,
        storeName,
        items,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Failed: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            const SizedBox(height: 120),
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
                    'Moreleta Pack, Unite B, Office 4, Office Eats Tech',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
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
                    'Delivery Instruction',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Call me when you are near my office',
                    style: TextStyle(
                      fontSize: 17,
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
                  const Text(
                    'Katlego Molepo',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const Text(
                    '073 232 1122',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'mastercard',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('card ***3211',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              label: 'Check out',
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
