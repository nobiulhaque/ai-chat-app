
import 'package:flutter/material.dart';

// Horizontal scrolling chip selector
class HorizontalChipSelector extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String) onItemSelected;
  final Color selectedColor;
  final Color? unselectedColor;
  final Color selectedTextColor;
  final Color? unselectedTextColor;
  final double height;
  final double spacing;
  final EdgeInsets itemPadding;
  final double borderRadius;
  final double fontSize;

  const HorizontalChipSelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    this.selectedColor = Colors.blue,
    this.unselectedColor,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor,
    this.height = 48,
    this.spacing = 11,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = 12,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedItem == item;
          return Padding(
            padding: EdgeInsets.only(right: spacing),
            child: GestureDetector(
              onTap: () => onItemSelected(item),
              child: Container(
                padding: itemPadding,
                decoration: BoxDecoration(
                  color: isSelected
                      ? selectedColor
                      : (unselectedColor ?? Colors.grey[900]),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected
                        ? selectedTextColor
                        : (unselectedTextColor ?? Colors.grey[400]),
                    fontSize: fontSize,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;

  const SectionTitle({
    super.key,
    required this.title,
    this.color = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.fontFamily = 'Poppins',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}

// Outlined action button with icon
class OutlinedActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color textColor;
  final Color borderColor;
  final double iconSize;
  final double fontSize;
  // final double? widthFactor;
  final EdgeInsets padding;
  final double borderRadius;
  final double minHeight;
  final String? fontFamily;

  const OutlinedActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.iconColor = Colors.orange,
    this.textColor = Colors.orange,
    this.borderColor = Colors.orange,
    this.iconSize = 18,
    this.fontSize = 14,
    // this.widthFactor ,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    this.borderRadius = 8,
    this.minHeight = 40,
    this.fontFamily = 'Poppins',
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        // widthFactor: widthFactor ?? 0.5,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor, size: iconSize),
          label: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontFamily: fontFamily,
              fontSize: fontSize,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: borderColor),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            alignment: Alignment.centerLeft,
            minimumSize: Size(0, minHeight),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}

// Primary action button with optional suffix
class PrimaryActionButtonchat extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String? suffix;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final double borderRadius;
  final String? fontFamily;

  const PrimaryActionButtonchat({
    super.key,
    required this.onPressed,
    required this.label,
    this.suffix,
    this.backgroundColor = Colors.orange,
    this.textColor = Colors.black,
    this.height = 48,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.borderRadius = 16,
    this.fontFamily = 'Poppins',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fontFamily,
              ),
            ),
            if (suffix != null) ...[
              const SizedBox(width: 8),
              Text(
                suffix!,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
