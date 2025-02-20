import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:eats/shared/date_formatter.dart';
import 'package:eats/shared/delivery_bottom_navbar.dart';
import 'package:eats/shared/skeleton_loader.dart';

class MyOrderDelivery extends StatefulWidget {
  var routeName = '/myordersdelivery';

  @override
  _MyOrderDeliveryState createState() => _MyOrderDeliveryState();
}

class _MyOrderDeliveryState extends State<MyOrderDelivery> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> orderHistory = [];
  bool isLoading = true;
  late int getUserId;
  late int getDeliveryPartnerOfficeId;
  String orderStatus = "";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getUserId = prefs.getInt('userId') ?? 0;
      getDeliveryPartnerOfficeId = prefs.getInt('deliveryPartnerOfficeId') ?? 0;
    });

    getOrderDeliveryPartnerIdReq();
  }

  // getOrderDeliveryPartnerReq
  Future<void> getOrderDeliveryPartnerIdReq() async {
    try {
      List<dynamic> response = await storeService
          .getOrderDeliveryPartnerIdReq(getDeliveryPartnerOfficeId);

      setState(() {
        orderHistory = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // updateOrder
  Future<void> updateOrder(BuildContext context, var order) async {
    try {
      final items = (order['items'] as List).cast<Map<String, dynamic>>();

      if (order['orderStatus'] == 'Assigned to Delivery') {
        orderStatus = 'On the Way';
      } else if (order['orderStatus'] == "On the Way") {
        orderStatus = 'Arrived';
      } else if (order['orderStatus'] == "Arrived") {
        orderStatus = 'Completed';
      }

      await storeService.updateOrderReq(
        context,
        order['id'],
        order['userId'],
        order['totalAmount'],
        order['deliveryAddress'],
        order['paymentMethod'],
        orderStatus,
        order['orderDate'],
        order['officeId'],
        getDeliveryPartnerOfficeId,
        order['shopId'],
        order['orderCode'],
        order['storeName'],
        order['description'],
        items,
      );

      // Update the order locally
      setState(() {
        final index = orderHistory.indexWhere((o) => o['id'] == order['id']);
        if (index != -1) {
          orderHistory[index]['orderStatus'] = orderStatus;
        }
      });

      if (orderStatus == "Completed") {
        getOrderDeliveryPartnerIdReq();
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Failed: $e')),
      );
    }
  }

  // openWhatsApp
  Future<void> openWhatsApp() async {
    String phoneNumber = "0789298447";
    final url = 'https://wa.me/$phoneNumber';

    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  void orderDetailsDialog(BuildContext context, order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(order['storeName']),
              Text(order['orderCode']),
              Text('Chat with support for more details.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement chat functionality
                Navigator.of(context).pop();
              },
              child: Text('Chat'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addStatusReq(BuildContext context, var order) async {
    try {
      if (order['orderStatusHistory'] == null ||
          order['orderStatusHistory'].isEmpty) {
        throw Exception("No order status history available");
      }

      var latestStatusEntry = order['orderStatusHistory'].first;
      String latestStatus = latestStatusEntry['status'];

      print(latestStatus);

      if (latestStatus == 'Ready For Pickup') {
        orderStatus = 'Out For Delivery';
      } else if (latestStatus == "Out For Delivery") {
        orderStatus = 'Arrived';
      } else if (latestStatus == "Arrived") {
        orderStatus = 'Completed';
      } else {
        throw Exception("Invalid status transition");
      }

      int orderId = order['id'];

      await storeService.addStatusReq(context, orderId, orderStatus, getUserId);

      // Update the order locally
      // setState(() {
      //   final index = orderHistory.indexWhere((o) => o['id'] == order['id']);
      //   if (index != -1) {
      //     orderHistory[index]['orderStatus'] = orderStatus;
      //
      //     orderHistory[index]['orderStatusHistory'].add({
      //       'id': DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
      //       'orderId': orderId,
      //       'status': orderStatus,
      //       'updatedBy': getUserId, // Assuming this is your user ID
      //       'updatedAt': DateTime.now().toIso8601String(),
      //     });
      //   }
      // });

      // if (orderStatus == "Completed") {
        getOrderDeliveryPartnerIdReq();
      // }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage My Orders'),
      ),
      body: Container(
        child: isLoading
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5, // Number of skeletons
                itemBuilder: (context, index) {
                  return SkeletonLoader();
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  var order = orderHistory[index];

                  String latestStatus = order['orderStatusHistory'].isNotEmpty
                      ? order['orderStatusHistory'].first['status']
                      : "No Status";

                  return MenuItem(
                    imagePath: 'assets/images/image1.webp',
                    storeName: order['storeName'],
                    orderDate: order['orderDate'],
                    orderCode: order['orderCode'],
                    orderStatus: latestStatus,
                    orderAddress: order['deliveryAddress'],
                    chat: () async {
                      orderDetailsDialog(context, order);
                    },
                    // Pass orderCode
                    onTrackOrder: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setStringList(
                          'items',
                          order['items']
                              .map<String>((item) => item.toString())
                              .toList());

                      // Call update method to update the order
                      addStatusReq(context, order);
                    },
                  );
                },
              ),
      ),
      bottomNavigationBar: RoundedDeliveryBottomBar(
        selectedIndex: 1,
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String storeName;
  final String orderDate;
  final String orderCode;
  final String orderAddress;
  final String orderStatus;
  final VoidCallback chat; // Callback for the button press
  final VoidCallback onTrackOrder; // Callback for the button press

  MenuItem({
    required this.imagePath,
    required this.storeName,
    required this.orderDate,
    required this.orderCode,
    required this.orderAddress,
    required this.orderStatus,
    required this.chat,
    required this.onTrackOrder,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  String getOrderButtonTitle(String orderStatus) {
    switch (orderStatus) {
      case 'Assigned':
        return 'Pick Up';
      case 'Out For Delivery':
        return 'Arrived';
      case 'Arrived':
        return 'Complete';
      default:
        return 'Pick Up'; // Default fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    String nextButtonTitle = getOrderButtonTitle(widget.orderStatus);

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 3,
        right: 16.0,
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Ref ${widget.orderCode}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan),
                    ),
                    Text(
                      widget.storeName,
                      // Access widget properties with 'widget.'
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(DateFormatter.formatDate(widget.orderDate),
                        style: TextStyle(fontSize: 16)),
                  ],
                )),
                SizedBox(width: 2),

                // Pending
                Container(
                    // color: Colors.orange,
                    decoration: BoxDecoration(
                      color: Color(0xFFfeddc1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      child: Text(
                        widget.orderStatus,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Colors.orange),
                      ),
                    )),
              ],
            ),
            Divider(),
            Text(
              widget.orderAddress,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: widget.chat, // Trigger the callback
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 0.0),
                  ),
                  child: const Text(
                    'Chat',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: widget.onTrackOrder, // Trigger the callback
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 0.0),
                  ),
                  child: Text(
                    nextButtonTitle,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
