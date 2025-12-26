import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';

class CustomAlertDialog {
  static void show({
    required BuildContext context,
    required String title,
    String? subtitle,
    String okButtonText = 'Ok',
    String? retryButtonText,
    VoidCallback? onOkPressed,
    VoidCallback? onRetryPressed,
    bool dismissible = true,
  }) {
    showDialog(
      
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 24.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                if (subtitle != null) ...[
                  SizedBox(height: 12.h),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],

                SizedBox(height: 24.h),

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (retryButtonText != null)
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onRetryPressed?.call();
                        },
                        child: Text(
                          retryButtonText,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (retryButtonText != null) SizedBox(width: 12.w),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onOkPressed?.call();
                      },
                      child: Text(
                        okButtonText,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}