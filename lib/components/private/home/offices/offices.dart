import 'package:flutter/material.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/skeleton_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfficePage extends StatefulWidget {
  var routeName = '/office';

  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  final StoreApiService storeService = StoreApiService();
  final TextEditingController searchController = TextEditingController();

  List<dynamic> offices = [];
  List<dynamic> filteredOffices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getOffices();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredOffices = query.isEmpty
          ? offices
          : offices.where((office) {
              return office['officeName']
                      .toString()
                      .toLowerCase()
                      .contains(query) ||
                  office['officeLocation']
                      .toString()
                      .toLowerCase()
                      .contains(query);
            }).toList();
    });
  }

  Future<void> getOffices() async {
    try {
      List<dynamic> response = await storeService.getOfficesReq();
      setState(() {
        offices = response;
        filteredOffices = response; // Initially, show all offices.
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
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Search
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
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

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: AppColors.secondaryColor,
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  // padding: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Office Eats',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Enjoy effortless, delicious meals ready for quick and easy pickup',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                        child: Image.asset(
                          'assets/images/order.png',
                          height: 160,
                          fit: BoxFit.cover, // Optional, to handle image scaling
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      itemCount: filteredOffices.length,
                      itemBuilder: (context, index) {
                        var office = filteredOffices[index];
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
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
                                Image.asset(
                                  'assets/images/officepack.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Office Pack: ${office['officeName']}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: AppColors.primaryColor,
                                              size: 20),
                                          Text(
                                            '${office['officeLocation']}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('officeId', office['id']);
                            await prefs.setString(
                                'officeName', office['officeName']);
                            await prefs.setString(
                                'officeLocation', office['officeLocation']);
                            await prefs.setInt('categoryId', 0);

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => true);
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}
