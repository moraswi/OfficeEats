import 'package:flutter/material.dart';

import '../../../../core/utilils/app_colors.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust the height according to your needs
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(10, (index) {
            return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                radius: 50, // Adjust the size of the circle
                backgroundColor: AppColors.backgroundColor,
                // child: Image.asset('assets/images/image1.webp')
                backgroundImage: AssetImage('assets/images/image1.webp'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
