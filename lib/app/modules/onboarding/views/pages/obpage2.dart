// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/utils/utils.dart';

import '../../../../routes/app_pages.dart';

class Obpage2 extends StatefulWidget {
  const Obpage2({super.key});

  @override
  State<Obpage2> createState() => _Obpage2State();
}

class _Obpage2State extends State<Obpage2> {
  final Set<int> _selectedIndices = {};

  static final List<_VibeCardData> _vibes = [
    _VibeCardData(
      title: 'Bold energy 💬'.tr,
      subtitle: 'When you want your message to land strong.'.tr,
    ),
    _VibeCardData(
      title: 'Confidence in every word ✨'.tr,
      subtitle: 'Express yourself with boldness and ease.'.tr,
    ),
    _VibeCardData(
      title: 'Fun vibes only 💋'.tr,
      subtitle: 'Make every message feel easy and engaging.'.tr,
    ),
    _VibeCardData(
      title: 'Soft but strong 🎯'.tr,
      subtitle: 'Because kindness always connects'.tr,
    ),
    _VibeCardData(
      title: 'Flirty vibes 🔥'.tr,
      subtitle: 'Add a playful spark and catch their attention.'.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120.h,
                  child: Image.asset(
                    'assets/icons/hat.png',
                    fit: BoxFit.contain,
                  ),
                ),

                Text(
                  'What\'s the vibe? 💬'.tr,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 40.h),

                ..._buildVibeCards(context),
                SizedBox(height: 25.h),

                // SpinKitThreeBounce(color: Colors.white, size: 12.0.r),

                SizedBox(height: 25.h),

                Utils.primaryButton(
                  context: context,
                  child: Text(
                    'Lock it in ✨'.tr,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  radius: 16.r,
                  height: 48.h,
                  backgroundColor: AppColors.secondaryColor,
                  textColor: AppColors.black,
                  onTap: () {
                    Get.toNamed(Routes.OBPAGE4);
                  },
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVibeCards(BuildContext context) {
    return _vibes
        .asMap()
        .entries
        .expand(
          (entry) => [
        _VibeCard(
          vibe: entry.value,
          context: context,
          isSelected: _selectedIndices.contains(entry.key),
          onTap: () {
            setState(() {
              if (_selectedIndices.contains(entry.key)) {
                _selectedIndices.remove(entry.key);
              } else {
                _selectedIndices.add(entry.key);
              }
            });
          },
        ),
        if (entry.key < _vibes.length - 1) SizedBox(height: 10.h),
      ],
    )
        .toList();
  }
}

class _VibeCard extends StatelessWidget {
  final _VibeCardData vibe;
  final BuildContext context;
  final bool isSelected;
  final VoidCallback onTap;

  const _VibeCard({
    required this.vibe,
    required this.context,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.0.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.white.withAlpha(13)
              : AppColors.white.withAlpha(26),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: isSelected ? 1.0 : 0.0,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                vibe.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                vibe.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VibeCardData {
  final String title;
  final String subtitle;

  _VibeCardData({required this.title, required this.subtitle});
}
