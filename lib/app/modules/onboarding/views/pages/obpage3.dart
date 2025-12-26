import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/utils/utils.dart';

import '../../../../routes/app_pages.dart';

class Obpage3 extends StatelessWidget {
  const Obpage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 120.h),
              SizedBox(
                height: 120.h,
                child: Image.asset('assets/icons/hat.png', fit: BoxFit.contain),
              ),
              Text(
                'Got a referral?'.tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              // Referral code text field
              Utils.customTextField(
                context: context,
                hintText: 'Enter referral code'.tr,
                hintFontSize: 12.sp,
                radius: 12.r,
                textColor: Colors.white,
              ),
              SizedBox(height: 80.h),
              // Continue button
              Utils.primaryButton(
                context: context,
                child: Text(
                  'I got a referral 🚀'.tr,
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
                  // Get.toNamed('/obpage4');
                  Get.snackbar('Oops!', 'Enter a referral code');
                },
              ),
              SizedBox(height: 10.h),
              // Skip button
              GestureDetector(
                onTap: () {
                  // CustomAlertDialog.show(
                  //   context: context,
                  //   title: "Oops! Can’t find that user 😅".tr,
                  //   subtitle: 'Retry 💡'.tr,
                  //   okButtonText: 'Ok'.tr,
                  //   onOkPressed: () {},
                  // );
                  Get.toNamed(Routes.OBPAGE4);
                },
                child: Text(
                  'Skip'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    color: Colors.white.withAlpha(128),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
