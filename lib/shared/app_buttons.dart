import 'package:flutter/material.dart';
import 'app_colors.dart'; // Import the colors file

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary; // To differentiate between primary and secondary buttons

  // Constructor
  CustomButton({
    required this.label,
    required this.onTap,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: AppColors.primaryColor,
          minimumSize: Size(double.infinity, 0),
        padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
      ),
      child: Text(label, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
    );
  }
}
