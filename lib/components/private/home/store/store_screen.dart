import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../shared/bottom_nav_bar.dart';

class StoreCard extends StatelessWidget {
  final String imagePath;
  final String storeName;
  final double rating; // Changed to double to support fractional ratings
  final Color backgroundColor;

  StoreCard({
    required this.imagePath,
    required this.storeName,
    required this.rating,
    this.backgroundColor = Colors.white, // Default color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(16),
        height: 200, // Adjust the height according to your needs
        decoration: BoxDecoration(
          color: backgroundColor, // Set background color of the card
          borderRadius: BorderRadius.circular(10), // Rounded corners
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
                          index < rating
                              ? Icons.star
                              : Icons.star_border, // Show filled or outlined star
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 100,),
          // Uncomment and use TopBar if needed
          // TopBar(),
          // Uncomment and use TextField if needed for search
          TextField(
            //controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 50,),

          // Example StoreCard instances with dummy data
          StoreCard(
            imagePath: 'assets/images/image1.webp', // Replace with your image path
            storeName: 'Store Name 1',
            rating: 4.5,
          ),
          StoreCard(
            imagePath: 'assets/images/food9.jpeg', // Replace with your image path
            storeName: 'Store Name 2',
            rating: 3.8,
          ),
          // Add more StoreCard instances as needed
        ],
      ),
      bottomNavigationBar: RoundedBottomBar(
        selectedIndex: 0,
      ),
    );
  }
}
