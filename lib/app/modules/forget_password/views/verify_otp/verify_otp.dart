import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/forget_password/views/widgets/otp_field.dart';
import '../../../../../core/utils/utils.dart';
import '../../controllers/verify_otp_controller.dart';
import '../widgets/circular_back_button.dart';

class VerifyOtp extends StatelessWidget {
  VerifyOtp({super.key});

  final controller = Get.put(VerifyOtpController());

  @override
  Widget build(BuildContext context) {
    final emailOrPhone = Get.arguments?['email'] ?? "";
    controller.emailOrPhone = emailOrPhone;

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
              "Verify OTP",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              "Enter the 6-digit code sent to your email",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),

            SizedBox(height: 50.h),

            Text(
              "Enter Code",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),

            SizedBox(height: 24.h),

            OtpField(controller: controller.otpController),

            SizedBox(height: 38.h),

            Obx(() => Utils.primaryButton(
              context: context,
              borderColor: Colors.transparent,
              onTap: controller.isLoading.value
                  ? null
                  : controller.verifyOtp,
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
                    "Verify Code",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 12.w),
                  Icon(Icons.arrow_forward),
                ],
              ),
            )),

            SizedBox(height: 38.h),
          ],
        ),
      ),
    );
  }
}
