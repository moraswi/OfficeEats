import 'package:flutter/material.dart';
import '../../../../core/utilils/app_colors.dart';

class FoodCategory {
  final String name;
  final String imagePath;

  FoodCategory({required this.name, required this.imagePath});
}

// Define a list of food categories
final List<FoodCategory> foodCategories = [
  FoodCategory(name: 'Meal', imagePath: 'assets/images/food10.jpeg'),
  FoodCategory(name: 'Drinks', imagePath: 'assets/images/food9.jpeg'),
  FoodCategory(name: 'Fast Food', imagePath: 'assets/images/food9.jpeg'),
  FoodCategory(name: 'Hot Deals', imagePath: 'assets/images/food8.jpeg'),
  FoodCategory(name: 'All', imagePath: 'assets/images/food7.jpeg'),
  // Add more categories as needed
];

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    //  height: 130, // Adjusted to accommodate the title below the circle
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(foodCategories.length, (index) {
            final category = foodCategories[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Handle the tap event here
                  print('${category.name} tapped');
                  // You can navigate to another page or show a dialog here
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45, // Adjust the size of the circle
                      backgroundColor: AppColors.backgroundColor,
                      backgroundImage: AssetImage(category.imagePath),
                    ),
                    SizedBox(height: 8.0), // Space between the circle and the title
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
