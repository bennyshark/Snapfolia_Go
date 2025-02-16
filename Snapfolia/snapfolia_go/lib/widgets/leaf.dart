import 'package:flutter/material.dart';

class LeafInfo extends StatelessWidget {
  final String image;
  final String name;
  const LeafInfo({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Card(
      color: Color(0xff282828),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Make image height relative to screen size
          Image.asset(
            image,
            height: screenHeight * 0.103, //35
          ),
          // Make text size responsive
          Text(
            name,
            style: TextStyle(
              fontSize: screenWidth * 0.037, // 5% of screen width
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
