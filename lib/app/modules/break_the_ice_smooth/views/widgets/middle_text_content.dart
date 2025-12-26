import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// Reusable widget for an icon
class StepIcon extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;

  const StepIcon({
    super.key,
    required this.assetPath,
    this.width = 48,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
    );
  }
}

// Reusable widget for step text
class StepText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const StepText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

// Using the widgets
class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children:  [
          StepIcon(assetPath: 'assets/icons/blockgame.png'),
          SizedBox(height: 24),
          StepText(text: 'Step 1: Pick a topic below'.tr),
          SizedBox(height: 8),
          StepText(
            text: 'Step 2: Hit Make Magic\nHappen'.tr,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          StepIcon(assetPath: 'assets/icons/blockgame.png'),
        ],
      ),
    );
  }
}
