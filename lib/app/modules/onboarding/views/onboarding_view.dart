import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/services/storage_services/storage_service.dart';
import 'package:social_wizard_app/core/utils/utils.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  static const double _iconSize = 50;
  static const double _spacing = 20;

  static const List<Map<String, String>> _features = [
    {
      'icon': 'assets/icons/messages.png',
      'text': 'Never get left on read'
    },
    {
      'icon': 'assets/icons/notes.png',
      'text': 'Say the right thing, every time',
    },
    {
      'icon': 'assets/icons/face.png',
      'text': 'Read the room like a pro'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();
    storage.markOnboardingSeen();
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              _buildAppLogo(),
              SizedBox(height: 50.h),
              _buildFeaturesList(context),
              const Spacer(),
              _buildTermsText(context),
              SizedBox(height: 20.h),
              _buildGetStartedButton(context),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Image.asset('assets/images/appLogo.png', height: 140.h);
  }

  Widget _buildFeaturesList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _features
            .asMap()
            .entries
            .map(
              (entry) => Padding(
            padding: EdgeInsets.only(
              bottom: entry.key != _features.length - 1 ? _spacing.h : 0,
            ),
            child: _buildFeatureRow(
              context,
              entry.value['icon']!,
              entry.value['text']!.tr,
            ),
          ),
        )
            .toList(),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, String iconPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(iconPath, width: _iconSize, height: _iconSize),
        SizedBox(width: 10.w),

        /// FIX: Text now flexible + auto line wrap
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText(BuildContext context) {
    return Text(
      'Tap "Get Started" to agree to our Terms and \nPrivacy Policy.'.tr,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Utils.primaryButton(
      context: context,
      height: 48.h,
      radius: 16.r,
      fontSize: 22.sp,
      backgroundColor: AppColors.secondaryColor,
      textColor: AppColors.black,
      child: Text(
        'Im in!'.tr,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      onTap: () => Get.offAndToNamed(Routes.OBPAGE1),
    );
  }
}
