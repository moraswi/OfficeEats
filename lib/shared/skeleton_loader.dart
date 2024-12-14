import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18,
                  width: 150,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 100,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
