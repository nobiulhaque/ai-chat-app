import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/utils/utils.dart';

class Obpage1 extends StatelessWidget {
  const Obpage1({super.key});

  static const List<_FeatureCardData> _features = [
    _FeatureCardData(
      title: 'Help me reply ✨',
      subtitle: 'Get the perfect response, instantly.',
      backgroundColor: Color(0xFF7A42FF),
    ),
    _FeatureCardData(
      title: 'Breaking the ice 👋',
      subtitle: 'Slide in smooth, no awkward openers.',
      backgroundColor: Color(0xFFFFD36E),
    ),
    _FeatureCardData(
      title: 'Read the vibe check 🧠',
      subtitle: 'Know if she\'s feeling it or just being nice.',
      backgroundColor: Color(0xFFFF4F81),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Column(
            children: [
              SizedBox(height: 150.h),
              Text(
                'What are we working on? 💬'.tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60.h),
              ..._buildFeatureCards(context),
              const Spacer(),
              Utils.primaryButton(
                context: context,
                child: Text(
                  'Let\'s go ⭐'.tr,
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
                  Get.toNamed(Routes.OBPAGE2);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // List<Widget> _buildFeatureCards(BuildContext context) {
  //   return _features
  //       .map((feature) => _FeatureCard(feature: feature, context: context))
  //       .toList()
  //       .fold<List<Widget>>([], (list, card) {
  //     list.add(card);
  //     if (card != _features.last) {
  //       list.add(SizedBox(height: 10.h));
  //     }
  //     return list;
  //   });
  // }

  List<Widget> _buildFeatureCards(BuildContext context) {
    return _features.asMap().entries.map((entry) {
      final index = entry.key;
      final feature = entry.value;

      final card = _FeatureCard(feature: feature, context: context);

      // Add spacing after card except for the last one
      if (index < _features.length - 1) {
        return Column(
          children: [
            card,
            SizedBox(height: 10.h),
          ],
        );
      } else {
        return card;
      }
    }).toList();
  }

}

class _FeatureCard extends StatelessWidget {
  final _FeatureCardData feature;
  final BuildContext context;

  const _FeatureCard({
    required this.feature,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.0.w),
      decoration: BoxDecoration(
        color: feature.backgroundColor.withAlpha(26),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              feature.title.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              feature.subtitle.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCardData {
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const _FeatureCardData({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
  });
}
