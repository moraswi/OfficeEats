import 'package:flutter/material.dart';
import 'package:eats/http/storeApiService.dart';

class FoodCategory {
  final String name;
  final String imagePath;

  FoodCategory({required this.name, required this.imagePath});
}

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> menus = [];
  bool isCategoriesLoading = true;

  @override
  void initState() {
    super.initState();
    getStoreMenuCategoriesReq();
  }

  Future<void> getStoreMenuCategoriesReq() async {
    try {
      var storeId = 0;
      List<dynamic> response =
          await storeService.getStoreMenuCategoriesReq(storeId);
      setState(() {
        menus = response;
        isCategoriesLoading = false;
      });
    } catch (e) {
      setState(() {
        isCategoriesLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Store categories failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isCategoriesLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 50, // Adjust height to fit the circle avatar and text
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Set horizontal scrolling
              itemCount: menus.length,
              itemBuilder: (context, index) {
                var menu = menus[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                      print('${menu['name']} tapped');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            child: Text(
                              menu['name'] ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
