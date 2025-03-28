import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/http/storeApiService.dart';
import 'package:eats/shared/skeleton_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/top_bar.dart';
import 'dart:typed_data';

class MenuPage extends StatefulWidget {
  var routeName = '/storemenu';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final StoreApiService storeService = StoreApiService();
  List<dynamic> menus = [];
  bool isLoading = true;
  late int getCategoryId;
  String getShopName = "";
  String getOfficeName = "";
  String getShopAddress = "";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();
    final categoryId = prefs.getInt('categoryId') ?? 0;
    setState(() {
      getCategoryId = categoryId;
      getShopName = prefs.getString('shopName') ?? "";
      getOfficeName = prefs.getString('officeName') ?? '';
      getShopAddress = prefs.getString('shopAddress') ?? '';
    });

    if (getCategoryId != null) {
      getStoreMenuByCategoryIdReq();
    }
  }

  // getStoreMenuByCategoryIdReq
  Future<void> getStoreMenuByCategoryIdReq() async {
    try {
      List<dynamic> response =
          await storeService.getStoreMenuByCategoryIdReq(getCategoryId);

      setState(() {
        menus = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // _onCategorySelected
  void _onCategorySelected(int categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('categoryId', categoryId);

    setState(() {
      getCategoryId = categoryId;
      isLoading = true;
    });
    getStoreMenuByCategoryIdReq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: AppBar(
          backgroundColor: Colors.white,

          flexibleSpace: ClipRRect(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/menuBg.webp"),
                      fit: BoxFit.fill)),
            ),
          ),
          title: Text(''),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle back action
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_sharp,
                  size: 28, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/cart', (Route<dynamic> route) => true);
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getShopName,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Text(getShopAddress.isEmpty
                        ? "${getOfficeName} Office Pack"
                        : getShopAddress),
                  ],
                ),
              ),
            ),
            const Row(children: [
              Icon(
                Icons.star,
                color: Color(0xFFF9A825),
                size: 20,
              ),
              Icon(
                Icons.star,
                color: Color(0xFFF9A825),
                size: 20,
              ),
              Icon(
                Icons.star,
                color: Color(0xFFF9A825),
                size: 20,
              ),
              Icon(
                Icons.star,
                color: Color(0xFFF9A825),
                size: 20,
              ),
              Icon(
                Icons.star,
                color: Color(0xFFF9A825),
                size: 20,
              ),
            ]),
            TopBar(onCategorySelected: _onCategorySelected),
            Expanded(
              child: SingleChildScrollView(
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
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            var menu = menus[index];

                            // Decode the Base64 image string
                            Uint8List? imageBytes;
                            if (menu['storeMenuImages'] != null &&
                                menu['storeMenuImages']['base64'] != null) {
                              imageBytes = base64Decode(
                                  menu['storeMenuImages']['base64']);
                            }

                            return MenuItem(
                              imageBytes: imageBytes,
                              id: menu['id'],
                              name: menu['name'],
                              description: menu['description'],
                              price: menu['price'],
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt('foodId', menu['id']);
                                prefs.setDouble('menuItemPrice', menu['price']);
                                prefs.setString('menuItemName', menu['name']);
                                prefs.setString(
                                    'description', menu['description']);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/menucustomization',
                                    (Route<dynamic> route) => true);
                              },
                            );
                          },
                        ),

                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}

// MenuItem
class MenuItem extends StatefulWidget {
  final int id;
  final Uint8List? imageBytes;
  final String name;
  final String description;
  final double price;
  final VoidCallback onTap;

  MenuItem({
    required this.id,
    this.imageBytes,
    required this.name,
    required this.description,
    required this.price,
    required this.onTap,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.all(8.0),
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
              widget.imageBytes != null
                  ? Image.memory(
                      widget.imageBytes!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/noimage.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Of Food
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  // description
                  Text('${widget.description}', style: TextStyle(fontSize: 13)),

                  // button and amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\R${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.secondaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
