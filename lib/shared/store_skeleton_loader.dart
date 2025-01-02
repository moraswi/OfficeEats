import 'package:flutter/material.dart';

class StoreSkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        // Adds spacing between cards
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          boxShadow: const [
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
                color: Colors.grey[400], // Placeholder for background image
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 150,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.only(right: 4),
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonLoaderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0), // Adds padding around the entire list
      itemCount: 10, // Number of skeleton loaders
      itemBuilder: (context, index) {
        return StoreSkeletonLoader(); // Individual skeleton loader
      },
    );
  }
}
