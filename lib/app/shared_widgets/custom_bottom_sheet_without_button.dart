import 'package:flutter/material.dart';

class SimpleBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;

  const SimpleBottomSheet({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title Center + Close Button Right
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Content Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: content,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
