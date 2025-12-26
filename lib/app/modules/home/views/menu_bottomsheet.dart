import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/shared_widgets/custom_bottom_sheet_without_button.dart';

import '../controllers/more_options_controller.dart';


void showBottomSheetHome(BuildContext context) {
  final controller = Get.put(MoreOptionsController());

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return SimpleBottomSheet(
        title: "More Stuff".tr,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            // 7 days FREE Button
            _buildSevenDaysFreeButton(context, controller),

            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),

            // Join Discord
            _buildMenuButton(
              label: 'Join discord'.tr,
              iconPath: 'assets/icons/discord.png',
              onPressed: controller.joinDiscord,
            ),

            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),

            // Contact Us
            _buildMenuButton(
              label: 'Contact us'.tr,
              iconPath: 'assets/icons/mail.png',
              onPressed: controller.contactSupport,
            ),

            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),

            // Rate Us
            _buildMenuButton(
              label: 'Rate us'.tr,
              iconPath: 'assets/icons/star.png',
              onPressed: controller.rateApp,
            ),

            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 20.h),

            // Footer: Terms, Version, Privacy
            _buildFooter(controller),

            SizedBox(height: 20.h),
          ],
        ),
      );
    },
  );
}

// 7 Days Free Button
Widget _buildSevenDaysFreeButton(
    BuildContext context,
    MoreOptionsController controller,
    ) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
      _showSevenDaysFreeBottomSheet(context, controller);
    },
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
    ),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '7 days FREE unlimited!'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8.w),
          Image.asset(
            'assets/icons/staff.png',
            width: 20.w,
            height: 20.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    ),
  );
}

// Generic Menu Button
Widget _buildMenuButton({
  required String label,
  required String iconPath,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        SizedBox(width: 8.w),
        Image.asset(
          iconPath,
          width: 20.w,
          height: 20.h,
        ),
      ],
    ),
  );
}

// Footer with Terms, Version, Privacy
Widget _buildFooter(MoreOptionsController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: controller.openTerms,
          child: Text(
            "Terms".tr,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ),
        Text(
          controller.appVersion,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        TextButton(
          onPressed: controller.openPrivacy,
          child: Text(
            "Privacy".tr,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}

// 7 Days Free Bottom Sheet
void _showSevenDaysFreeBottomSheet(
    BuildContext context,
    MoreOptionsController controller,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SimpleBottomSheet(
        title: "7 Days Free",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Infinity + Staff Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/infinity.png',
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 25.w),
                Image.asset(
                  'assets/icons/staff.png',
                  width: 60.w,
                  height: 55.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Friends invited + Join button
            Row(
              children: [
                Obx(() => Text(
                  "Friends invited: ${controller.friendsInvited.value}",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const Spacer(),

                // Join to claim TextButton
                TextButton(
                  onPressed: controller.openDiscordToClaim,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/discordBlue.png',
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Join to claim",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Code display container
            Center(
              child: Container(
                width: 392.w,
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.referralCode,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        letterSpacing: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.copyReferralCode,
                      child: Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Share Code Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.shareReferralCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Share code",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Info text
            Center(
              child: Text(
                "Invited friends would have to go through a free trial",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      );
    },
  );
}