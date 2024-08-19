import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  final String imagePath = 'assets/images/your-image.jpg'; // Replace with your local image path
  final String storeName = 'Store Name';
  final String rate = '4';
  final Color backgroundColor = Colors.white; // Set your desired background color here

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 200, // Adjust the height according to your needs
      decoration: BoxDecoration(
        color: backgroundColor, // Set background color of the card
        borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
        boxShadow: [ // Optional: Shadow for card elevation
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
              color: Colors.black54, // Background color of the store name area
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    rate,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),

                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
