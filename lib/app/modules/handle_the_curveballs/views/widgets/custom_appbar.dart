import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final double elevation;
  final String firstImage;
  final String secondImage;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    this.backgroundColor = Colors.black,
    this.elevation = 0,
    required this.firstImage,
    required this.secondImage,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leadingWidth: 150, // Adjust width to fit widgets
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBackPressed ?? () => Navigator.pop(context),
          ),
          const SizedBox(width: 4),
          Image.asset(
            firstImage,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 4),
          Image.asset(
            secondImage,
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
