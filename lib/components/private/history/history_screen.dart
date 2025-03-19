import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/date_formatter.dart';
import '../../../shared/skeleton_loader.dart';

import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String name;
  final String orderDate;
  final String orderCode;
  final VoidCallback onTrackOrder; // Callback for the button press

  MenuItem({
    required this.imagePath,
    required this.name,
    required this.orderDate,
    required this.orderCode,
    required this.onTrackOrder,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Set the grey color for the border
            width: 1.0, // Set the thickness of the border
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name, // Access widget properties with 'widget.'
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormatter.formatDateTime(widget.orderDate),
                    style: TextStyle(fontSize: 16)),
                Text(
                  widget.orderCode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          ElevatedButton(
            onPressed: widget.onTrackOrder, // Trigger the callback
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              // Keep the background white
              elevation: 0,
              // Remove the shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              // Use the arrow icon or any other icon you prefer
              color: Colors.black,
              size: 20.0, // Adjust the size of the icon
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryPage extends StatefulWidget {
  var routeName = '/history';

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> orderHistory = [];
  bool isLoading = true;
  late int getUserId;

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getUserId = prefs.getInt('userId') ?? 0;
    });

    getOrdersReq();
  }

  Future<void> getOrdersReq() async {
    try {
      List<dynamic> response = await storeService.getOrdersReq(getUserId);
      setState(() {
        response.sort(
            (a, b) => b['id'].compareTo(a['id'])); // Sort by ID descending
        orderHistory = response;
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
        title: Text('My Orders'),
        automaticallyImplyLeading: false,
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
            : orderHistory.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history_outlined,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No orders yet!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 20),
                          // CustomButton(
                          //   label: 'Start Shopping',
                          //   onTap: () {
                          //     // Navigate to the shopping page
                          //     Navigator.of(context).pushNamed('/shop');
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderHistory.length,
                    itemBuilder: (context, index) {
                      var order = orderHistory[index];

                      return MenuItem(
                        imagePath: 'assets/images/image1.webp',
                        name: order['storeName'],
                        orderDate: order['orderDate'],
                        orderCode: order['orderCode'],
                        // Pass orderCode
                        onTrackOrder: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('orderId', order['id']);
                          await prefs.setString(
                              'storeName', order['storeName']);
                          await prefs.setInt('storeId', order['shopId']);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/trackorder',
                            (Route<dynamic> route) => true,
                          );
                        },
                      );
                    },
                  ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 1,
      ),
    );
  }
}
