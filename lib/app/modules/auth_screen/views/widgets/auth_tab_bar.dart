// Reusable Dynamic TabBar Widget

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/app_colors.dart';

class AuthTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final Color indicatorColor;
  final double indicatorHeight;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final double? height;

  const AuthTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.selectedColor = AppColors.primaryColor,
    this.unselectedColor = AppColors.white,
    this.indicatorColor = AppColors.primaryColor,
    this.indicatorHeight = 3,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;

        return Expanded(
          child: GestureDetector(
            onTap: () => onTabChanged(index),
            child: Container(
              height: height,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? indicatorColor
                        : Colors.transparent,
                    width: indicatorHeight.w,
                  ),
                ),
              ),
              padding:  EdgeInsets.only(bottom: 12.h),
              child: Text(
                tabs[index],
                textAlign: TextAlign.center,
                style: isSelected
                    ? (selectedTextStyle ??
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: selectedColor,
                      fontWeight: FontWeight.w600,
                    ))
                    : (unselectedTextStyle ??
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: unselectedColor,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
        );
      }),
    );
  }
}