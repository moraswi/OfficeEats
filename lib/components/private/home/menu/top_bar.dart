import 'package:flutter/material.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodCategory {
  final String name;
  final String imagePath;

  FoodCategory({required this.name, required this.imagePath});
}

class TopBar extends StatefulWidget {
  final Function(int) onCategorySelected;

  const TopBar({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> menus = [];
  bool isCategoriesLoading = true;
  late int getStoreId;

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
    // getStoreMenuCategoriesReq();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getStoreId = prefs.getInt('storeId') ?? 1;
    });

    if (getStoreId != null) {
      getStoreMenuCategoriesReq();
    }
  }

  // getStoreMenuCategoriesReq
  Future<void> getStoreMenuCategoriesReq() async {
    try {
      List<dynamic> response =
          await storeService.getStoreMenuCategoriesReq(getStoreId);
      setState(() {
        menus = response;
        isCategoriesLoading = false;
      });
    } catch (e) {
      setState(() {
        isCategoriesLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return isCategoriesLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              itemBuilder: (context, index) {
                var menu = menus[index];
                return GestureDetector(
                  onTap: () {
                    widget.onCategorySelected(menu['id']); // Notify parent
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
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
