import 'package:flutter/material.dart';

class FeatureCardButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final String bottomText;
  final Color backgroundColor;
  final VoidCallback onTap;

  const FeatureCardButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.bottomText,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - 48;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        height: 225,
        width: cardWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: (screenWidth * 0.06).clamp(20.0, 24.0),
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: (screenWidth * 0.032).clamp(11.0, 12.0),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            // Icon
            Image.asset(
              iconPath,
              width: (screenWidth * 0.12).clamp(40.0, 48.0),
              height: (screenWidth * 0.12).clamp(40.0, 48.0),
            ),

            // Stars
            Image.asset(
              'assets/icons/ratingstar.png',
              width: (screenWidth * 0.32).clamp(100.0, 123.0),
              height: 25,
              fit: BoxFit.contain,
            ),

            // Bottom text
            Text(
              bottomText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: (screenWidth * 0.032).clamp(11.0, 12.0),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
