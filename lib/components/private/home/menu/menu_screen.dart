import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';
import 'package:eats/shared/app_buttons.dart';
import '../menu/top_bar.dart';

class MenuItem extends StatefulWidget {
  final String imagePath;
  final String name;
  final String description;
  final double price;
  final Function(int) onQuantityChanged; // Callback to notify parent

  MenuItem({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.onQuantityChanged,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int quantity = 0;

  void _increment() {
    setState(() {
      quantity++;
    });
    widget.onQuantityChanged(quantity); // Notify parent
  }

  void _decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
      widget.onQuantityChanged(quantity); // Notify parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Image.asset(
            widget.imagePath,
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
                  style: TextStyle(
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondaryColor
                        ),
                      ),

                    SizedBox(width: 150 ,),

                        Row(
                          children: [

                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: _decrement,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                            ),

                            SizedBox(width: 3,),

                            Text(
                              '$quantity',
                              style: TextStyle(fontSize: 16),
                            ),

                            SizedBox(width: 3,),

                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: _decrement,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),

                          ],
                        ),

                  ],
                )
              ],
            ),

        ],
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  var routeName = '/storemenu';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _totalQuantity = 0;

  void _updateTotalQuantity(int quantity) {
    setState(() {
      _totalQuantity += quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(180),
      child: AppBar(
        backgroundColor: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(0))
        ),

        flexibleSpace: ClipRRect(
           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(0)),
          child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
             image: AssetImage("assets/images/food2.jpeg"),
              fit: BoxFit.fill
            )
          ),
          ),
        ),
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_sharp,
                size: 28, color: AppColors.primaryColor),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mac D", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),),
                    Text("Villaboas Office Pack"),
                  ],
                ),
              ),
            ),

            const Row(
              children: [
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
                  ]
                ),

            TopBar(),
            Expanded(
              child: ListView(
                children: [
                  MenuItem(
                    imagePath: 'assets/images/image1.webp',
                    name: 'Food Item 1',
                    description: "description of item",
                    price: 12.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),
                  MenuItem(
                    imagePath: 'assets/images/food2.jpeg',
                    name: 'Food Item 1',
                    description: "description of item",
                    price: 12.99,
                    onQuantityChanged: _updateTotalQuantity,
                  ),

                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              label: 'My Cart',
              onTap: () {
                // Handle button press
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/cart', (Route<dynamic> route) => true);
              },
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
