import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/utils.dart';
import '../../controllers/reset_password_controller.dart';
import '../widgets/circular_back_button.dart';

class ResetPassowrd extends GetView<ResetPasswordController> {
  ResetPassowrd({super.key});
@override
  final controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    // Get token from arguments
    final args = Get.arguments;
    if (args != null) {
      controller.token = args['token'];
      debugPrint("Token received in UI: ${controller.token}");
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularBackButton(),
            SizedBox(height: 36.h),
            Text(
              "Reset Password".tr,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
              ),
            ),
            SizedBox(height: 50.h),

            Utils.customTextField(
              context: context,
              controller: controller.passwordController,
              title: 'Password'.tr,
              hintText: 'Enter your new password'.tr,
              obscureText: true,
            ),

            SizedBox(height: 24.h),

            Utils.customTextField(
              context: context,
              controller: controller.confirmPasswordController,
              title: 'Confirm Password'.tr,
              hintText: 'Enter your confirm password'.tr,
              obscureText: true,
            ),

            SizedBox(height: 38.h),

            Obx(
                  () => Utils.primaryButton(
                context: context,
                borderColor: Colors.transparent,
                child: controller.isLoading.value
                    ? SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset password'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                onTap: controller.isLoading.value
                    ? null
                    : () {
                  controller.resetPassword();
                },
              ),
            ),

            SizedBox(height: 38.h),
          ],
        ),
      ),
    );
  }
}
