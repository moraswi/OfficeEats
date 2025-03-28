import 'package:flutter/material.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eats/shared/date_formatter.dart';
import 'package:eats/shared/delivery_bottom_navbar.dart';
import 'package:eats/shared/skeleton_loader.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String storeName;
  final String orderDate;
  final String orderCode;
  final String orderStatus;
  final String orderAddress;
  final VoidCallback onTrackOrder; // Callback for the button press

  MenuItem({
    required this.imagePath,
    required this.storeName,
    required this.orderDate,
    required this.orderCode,
    required this.orderStatus,
    required this.orderAddress,
    required this.onTrackOrder,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
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
                child: const Text(
                  'Accept',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeliveryOrderPage extends StatefulWidget {
  var routeName = '/deliveryorder';

  @override
  _DeliveryOrderPageState createState() => _DeliveryOrderPageState();
}

class _DeliveryOrderPageState extends State<DeliveryOrderPage> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> orderHistory = [];
  bool isLoading = true;
  late int getDeliveryPartnerOfficeId;
  String orderStatus = "";
  late int getUserId;
  late int orderId;

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

    getOrderDeliveryPartnerReq();
  }

  // getOrderDeliveryPartnerReq
  Future<void> getOrderDeliveryPartnerReq() async {
    try {
      List<dynamic> response = await storeService
          .getOrderDeliveryPartnerReq(getDeliveryPartnerOfficeId);

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

      orderId = order['id'];

      // Call the API to update the order
      await storeService.updateOrderReq(
        context,
        orderId,
        getDeliveryPartnerOfficeId,
      );

      addStatusReq(context, orderId);
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Failed: $e')),
      );
    }
  }

  // addStatusReq
  Future<void> addStatusReq(BuildContext context, int orderId) async {
    try {
      orderStatus = 'Assigned';
      await storeService.addStatusReq(context, orderId, orderStatus, getUserId);
      getOrderDeliveryPartnerReq();
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
        title: Text('New Orders Delivery'),
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

                    // Pass orderCode
                    onTrackOrder: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setStringList(
                          'items',
                          order['items']
                              .map<String>((item) => item.toString())
                              .toList());

                      // Call update method to update the order
                      updateOrder(context, order);
                    },
                  );
                },
              ),
      ),
      bottomNavigationBar: RoundedDeliveryBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}
