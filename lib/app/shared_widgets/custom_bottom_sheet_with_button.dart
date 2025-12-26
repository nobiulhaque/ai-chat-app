import 'package:flutter/material.dart';

class CustomBottomSheetWidgets extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Widget? buttonIcon;
  final String? buttonSuffix;
  final Color buttonColor;
  final Color buttonTextColor;

  const CustomBottomSheetWidgets({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    this.buttonIcon,
    this.buttonSuffix,
    this.buttonColor = const Color(0xFFF59E0B),
    this.buttonTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440,
      decoration: const ShapeDecoration(
        color: Color(0xFF232323),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Handle
              Container(
                width: 375,
                height: 13,
                margin: const EdgeInsets.only(top: 8),
                child: Center(
                  child: Container(
                    width: 28,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),

              // Header Section (Centered)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Subtitle
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: content,
                ),
              ),

              // Bottom Section with Button
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: onButtonPressed,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: ShapeDecoration(
                          color: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText,
                              style: TextStyle(
                                color: buttonTextColor,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),
                            if (buttonIcon != null) ...[
                              const SizedBox(width: 8),
                              buttonIcon!,
                            ],
                            if (buttonSuffix != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                buttonSuffix!,
                                style: TextStyle(
                                  color: buttonTextColor,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),

          // Close Button (Top-Right)
          Positioned(
            right: 16,
            top: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
