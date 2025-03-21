import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../http/storeApiService.dart';
import '../../../shared/date_formatter.dart';

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
  int getStoreId = 0;
  String getPhoneNumber = "";
  String getFirstName = "";
  String getShorpName = "";
  double totalPrice = 0.0;
  double deliveryFee = 0.0;
  double subtotalPrice = 0.0;
  String getAccountNo = "";
  String getAccountRef = "";
  String getAccountName = "";
  String getAddress = "";

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
    });
    await getOrderByIdReq();
  }

  // getOrdersReq
  Future<void> getOrderByIdReq() async {
    try {
      Map<String, dynamic> response =
          await storeService.getOrderByIdReq(getOrderId);
      setState(() {
        orderHistory = [response];
        isLoading = false;

        if (orderHistory.isNotEmpty) {
          var order = orderHistory[0];
          subtotalPrice = order['totalAmount'];
          deliveryFee = order['deliveryFee'];
          getStoreId = order['shopId'];
          getAddress = '${order['recipientName']}, ${order['recipientMobileNumber']}, ${order['suburb']}, ${order['apartment']}, ${order['streetAddress']}';
        } else {
          subtotalPrice = 0.0;
          deliveryFee = 0.0;
          totalPrice = 0.0;
          getStoreId = 0;
          getAddress = '';
        }

        totalPrice = subtotalPrice + deliveryFee;

        
        // subtotalPrice =
        //     orderHistory.isNotEmpty ? orderHistory[0]['totalAmount'] : 0.0;
        // deliveryFee =
        //     orderHistory.isNotEmpty ? orderHistory[0]['deliveryFee'] : 0.0;
        // totalPrice = subtotalPrice + deliveryFee;
        //
        // getStoreId = orderHistory.isNotEmpty ? orderHistory[0]['shopId'] : 0.0;
        //
        //
        // getAddress = orderHistory.isNotEmpty
        //     ? orderHistory[0]['recipientName'] +
        //         ", " +
        //         orderHistory[0]['recipientMobileNumber'] +
        //         ", " +
        //         orderHistory[0]['suburb'] +
        //         ", " +
        //         orderHistory[0]['apartment'] +
        //         ", " +
        //         orderHistory[0]['streetAddress']
        //     : "";
      });

      await getStoreBankingDetailsReq();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // getStoreBankingDetailsReq
  // getStoreBankingDetailsReq
  Future<void> getStoreBankingDetailsReq() async {
    try {
      var response = await storeService.getStoreBankingDetailsReq(getStoreId);

      // Assuming response is a JSON object
      var data = jsonDecode(response.body);

      setState(() {
        getAccountNo = data['accountNumber'] ?? '';
        getAccountRef = data['reference'] ?? '';
        getAccountName = data['accountName'] ?? '';
      });
    } catch (error) {
      print('Error fetching banking details: $error');
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Aligns all text left
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          getShorpName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Order: ${orderHistory.isNotEmpty ? orderHistory[0]['orderCode'] ?? '' : ''}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          getAccountName,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Account Number: $getAccountNo",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ref: $getAccountRef',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Text(
                          'Please use order number (${orderHistory.isNotEmpty ? orderHistory[0]['orderCode'] ?? '' : ''}) as your reference')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                  // double totalPrice = 0.0;
                  // double deliveryFee = 0.0;

                  // if (orderHistory.isNotEmpty &&
                  //     orderHistory[0]['items'] != null) {
                  //   for (var item in orderHistory[0]['items']) {
                  //     totalPrice += (item['totalPrice'] ?? 0);
                  //   }
                  //   // totalPrice += deliveryFee;
                  // }
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
                          'Subtotal: R$subtotalPrice',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Delivery Fee:  R$deliveryFee',
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
                      if (orderHistory.isNotEmpty &&
                          orderHistory[0]['orderStatusHistory'] != null)
                        ...List.generate(
                          (orderHistory[0]['orderStatusHistory'] as List)
                              .length,
                          (index) {
                            final statusItem =
                                orderHistory[0]['orderStatusHistory'][index];
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          statusItem['status'],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          DateFormatter.formatTime(
                                              statusItem['updatedAt']),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
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
                        orderHistory.isNotEmpty ? getAddress ?? '' : '',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the chatboard page
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/chatbot',
            (Route<dynamic> route) => true,
          );
        },
        child: Icon(Icons.chat_bubble_outline), // Chat bubble icon
        tooltip: 'Go to Chatboard',
      ),
    );
  }
}
