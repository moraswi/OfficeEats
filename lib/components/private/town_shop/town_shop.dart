import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/store_skeleton_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreCard extends StatelessWidget {
  final Widget imagePath;
  final String storeName;
  final double rating;
  final Color backgroundColor;

  StoreCard({
    required this.imagePath,
    required this.storeName,
    required this.rating,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(child: imagePath), // Use the Widget directly
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TownShop extends StatefulWidget {
  var routeName = '/townshop';

  @override
  _TownShopState createState() => _TownShopState();
}

class _TownShopState extends State<TownShop> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> stores = [];
  List<dynamic> filteredStores = [];
  bool isLoading = true;

  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.8);

  late int getOfficeId;
  String getOfficeName = "";

  // final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // getSharedPreferenceData();
    _startAutoScroll();
    getStoresReq();
    searchController.addListener(_filterStores);
  }

  @override
  void dispose() {
    _timer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.page == 2) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getOfficeId = prefs.getInt('officeId') ?? 0;
      getOfficeName = prefs.getString('officeName') ?? '';
    });

    getStoresReq();
  }

  // _filterStores
  void _filterStores() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredStores = stores
          .where((store) => store['shopName'].toLowerCase().contains(query))
          .toList();
    });
  }

  // getStoresReq
  Future<void> getStoresReq() async {
    try {
      List<dynamic> response = await storeService.getStoresReq(0);
      setState(() {
        stores = response;
        print(stores);
        filteredStores = stores;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Get offices failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Our Stores'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/office', (Route<dynamic> route) => true);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_sharp,
              size: 28,
            ),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/cart', (Route<dynamic> route) => true);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            const SizedBox(height: 15),

            /// Office Eats Button
            InkWell(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Office Eats",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/myprofile',
                  (Route<dynamic> route) => false,
                );
              },
            ),

            const SizedBox(height: 15),

            /// Search Bar
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Store',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.all(8),
              ),
            ),

            const SizedBox(height: 15),


            /// ListView for Store Items
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                // Keeps vertical scrolling smooth
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // PageView remains horizontally scrollable
                    SizedBox(
                      height: 150,
                      child: PageView(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        // Ensures horizontal scrolling
                        children: [
                          _buildCard(Colors.black, 'Card 1',
                              'assets/images/food3.jpeg'),
                          _buildCard(Colors.black, 'Card 2',
                              'assets/images/food5.jpeg'),
                          _buildCard(Colors.black, 'Card 3',
                              'assets/images/food6.jpeg'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    // List of Stores
                    isLoading
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            // Prevents nested scroll conflicts
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                StoreSkeletonLoader(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredStores.length,
                            itemBuilder: (context, index) {
                              var store = filteredStores[index];
                              var storeImages = store['storeImages'];
                              var base64Image = storeImages != null
                                  ? storeImages['base64']
                                  : null;

                              Widget imageWidget =
                                  base64Image != null && base64Image.isNotEmpty
                                      ? Image.memory(
                                          base64Decode(base64Image),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : Image.asset(
                                          'assets/images/noimage.png',
                                          width: double.infinity,
                                          height: double.infinity,
                                        );

                              return GestureDetector(
                                onTap: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setInt('storeId', store['id']);
                                  await prefs.setString(
                                      'shopName', store['shopName']);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/storemenu',
                                    (Route<dynamic> route) => true,
                                  );
                                },
                                child: StoreCard(
                                  imagePath: imageWidget,
                                  storeName:
                                      store['shopName'] ?? 'Unknown Store',
                                  rating: 5,
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(selectedIndex: 0),
    );
  }

  // advert card
  Widget _buildCard(Color color, String text, String imagePath) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Ensures the image covers the card
              ),
            ),
          ),
          // Text overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(
                  0.3), // Optional: adds overlay for better readability
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
