import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/app_colors.dart';

import '../../../shared/date_formatter.dart';
import '../../../shared/skeleton_loader.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String name;
  final String orderDate;
  final String orderCode;

  MenuItem({
    required this.imagePath,
    required this.name,
    required this.orderDate,
    required this.orderCode,
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
          // Image.asset(
          //   widget.imagePath,
          //   width: 80,
          //   height: 80,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormatter.formatDate(widget.orderDate),
                    style: TextStyle(fontSize: 16)),
                Text(
                  '${widget.orderCode}',
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
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/trackorder', (Route<dynamic> route) => true);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 0.0), // Padding inside the button
            ),
            child: const Text(
              'Track Order',
              style: TextStyle(
                fontSize: 16.0, // Text size
              ),
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

  @override
  void initState() {
    super.initState();
    getOrdersReq();
  }

  // getOrdersReq
  Future<void> getOrdersReq() async {
    try {
      var userid = 0;
      List<dynamic> response = await storeService.getOrdersReq(userid);
      setState(() {
        orderHistory = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Get order failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),

      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                // children: [
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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

                            return MenuItem(
                              imagePath: 'assets/images/image1.webp',
                              name: order['storeName'],
                              orderDate: order['orderDate'],
                              orderCode: order['orderCode'],
                            );
                          }),
                ),

                // const SizedBox(
                //   height: 20,
                // ),
                // ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 1,
      ),
    );
  }
}
