import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';

import '../../../../routes/app_pages.dart';
import '../widgets/animated_button_widgets.dart';

class TrialScreen extends StatelessWidget {
  const TrialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 24.h,
                  bottom: 19.h,
                  left: 24.w,
                  right: 24.w,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 24.h,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/home');
                        },
                        child: Text(
                          'Not Now'.tr,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.secondaryColor.withAlpha(88),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: Text(
                        'Level up your Rizz Game'.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        'Stop overthinking. Start connecting 😎'.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Main Content Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  // Chat Preview Card
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white50, width: 2),
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF4F81).withAlpha(128),
                          Color(0xFF7A42FF).withAlpha(128),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.all(20.w),
                    child: Image.asset(
                      'assets/icons/trial.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Trial Info Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Try it free, cancel anytime'.tr,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Start Trial Button
                  // Utils.primaryButton(
                  //   context: context,
                  //   child: Text(
                  //     'Start my free trial✨'.tr,
                  //     style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  //       fontSize: 20.sp,
                  //       fontWeight: FontWeight.w500,
                  //       color: AppColors.black,
                  //     ),
                  //   ),
                  //   radius: 35.r,
                  //   height: 48.h,
                  //   backgroundColor: AppColors.primaryColor,
                  //   textColor: AppColors.black,
                  //   onTap: () {
                  //     Get.toNamed(Routes.PAYMENTS_MODULES);
                  //   },
                  // ),


                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0.r),
                    child: EncouragingWaveButton(
                      onTap: () {
                        Get.toNamed(Routes.PAYMENTS_MODULES);
                      },
                      height: 40.h,
                      radius: 35.r,
                      backgroundColor: AppColors.primaryColor,
                      waveColor: AppColors.primaryColor, // Wave এর color
                      child: Text(
                        'Start my free trial ✨'.tr,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),



                  SizedBox(height: 16.h),

                  // Pricing Info
                  Column(
                    children: [
                      Text(
                        'After 7 days, just \$3.99/week. Cancel anytime, no BS.'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white50,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'To stop renewal, cancel anytime in your Google Play Settings.'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white50,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 24.h,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


