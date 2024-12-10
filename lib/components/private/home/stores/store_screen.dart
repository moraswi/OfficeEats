import 'package:flutter/material.dart';
import 'package:eats/shared/bottom_nav_bar.dart';
import 'package:eats/shared/app_colors.dart';

class StoreCard extends StatelessWidget {
  final String imagePath;
  final String storeName;
  final double rating; // Changed to double to support fractional ratings
  final Color backgroundColor;

  StoreCard({
    required this.imagePath,
    required this.storeName,
    required this.rating,
    this.backgroundColor = Colors.grey, // Default color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), // Apply the same border radius
        child: Container(
          height: 200, // Adjust the height according to your needs
          decoration: BoxDecoration(
            color: backgroundColor, // Set background color of the card
            boxShadow: const [
              // Shadow for card elevation
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  // Background color of the store name area
                  padding: EdgeInsets.all(16),
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
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            // Show filled or outlined star
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
      ),
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/storemenu', (Route<dynamic> route) => true);
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  var routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Our Stores'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_sharp, size: 28,),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/cart', (Route<dynamic> route) => true);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child:Column(

          children: [
            SizedBox(height: 15,),

            // address
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
                  'Unit 54, Mogale Tech',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/profile',
                      (Route<dynamic> route) => false,
                );
              },
            ),

            const SizedBox(height: 15),

            // search textfield
            TextFormField(
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

            const SizedBox(height: 5),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height:15),
                    // Example StoreCard instances with dummy data
                    StoreCard(
                      imagePath: 'assets/images/image1.webp',
                      // Replace with your image path
                      storeName: 'Store Name 1',
                      rating: 4.5,
                    ),

                  ],
                ),
              ),
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