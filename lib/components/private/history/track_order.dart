import 'package:flutter/material.dart';

import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../http/storeApiService.dart';

class TrackOrderPage extends StatefulWidget {
  var routeName = '/trackorder';

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  //

  final StoreApiService storeService = StoreApiService();
  List<dynamic> orderHistory = [];
  bool isLoading = true;
  int getOrderId = 0;
  String getPhoneNumber = "";
  String getFirstName = "";
  String getShorpName = "";
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getOrderId = prefs.getInt('orderId') ?? 0;
      getShorpName = prefs.getString('storeName') ?? '';
      getFirstName = prefs.getString('firstName') ?? '';
      getPhoneNumber = prefs.getString('phoneNumber') ?? '';
      print(getOrderId);
    });
    getOrderByIdReq();
  }

  // getOrdersReq
  Future<void> getOrderByIdReq() async {
    try {
      Map<String, dynamic> response =
          await storeService.getOrderByIdReq(getOrderId);
      setState(() {
        orderHistory = [response];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getShorpName,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order: ${orderHistory.isNotEmpty ? orderHistory[0]['orderCode'] ?? '' : ''}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        // offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (orderHistory.isNotEmpty &&
                          orderHistory[0]['items'] != null)
                        ...List.generate(
                          (orderHistory[0]['items'] as List).length,
                          (index) {
                            final item = orderHistory[0]['items'][index];
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['foodName'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'Price: \R${item['totalPrice']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${item['quantity']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                      height: 16.0,
                                    ),
                                  ],
                                ));
                          },
                        )
                      else
                        const Text(
                          'No items available.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Builder(builder: (context) {
                  double totalPrice = 0.0;

                  if (orderHistory.isNotEmpty && orderHistory[0]['items'] != null) {
                    for (var item in orderHistory[0]['items']) {
                      totalPrice += (item['totalPrice'] ?? 0);
                    }
                  }
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          // offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    //alignment: Alignment.,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subtotal: R${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'Delivery Fee: R0.00',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Method: ${orderHistory.isNotEmpty ? orderHistory[0]['paymentMethod'] ?? '' : ''}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                          height: 16.0,
                        ),
                        Text(
                          'Total: R${(totalPrice).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        // offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  //alignment: Alignment.,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Status',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 16.0,
                      ),
                      Text(
                        orderHistory.isNotEmpty
                            ? orderHistory[0]['orderStatus'] ?? ''
                            : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        // offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  //alignment: Alignment.,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 16.0,
                      ),
                      Text(
                        orderHistory.isNotEmpty
                            ? orderHistory[0]['deliveryAddress'] ?? ''
                            : '',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        // offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  //alignment: Alignment.,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 16.0,
                      ),
                      Text(
                        getFirstName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        getPhoneNumber,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 1,
      ),
    );
  }
}
