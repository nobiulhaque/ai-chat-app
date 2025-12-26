import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/utils.dart';
import '../../controllers/send_otp.dart';
import '../widgets/circular_back_button.dart';

class VerifyEmailOrPhone extends StatelessWidget {
  VerifyEmailOrPhone({super.key});

  final controller = Get.put(VerifyEmailController());

  @override
  Widget build(BuildContext context) {
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
              "Verify Email".tr,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Enter your email to reset password".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 50.h),
            Utils.customTextField(
              context: context,
              controller: controller.emailController, // Controller যুক্ত
              title: 'Email',
              hintText: 'yourmail@mail.com',
            ),
            SizedBox(height: 38.h),
            Obx(() => Utils.primaryButton(
              context: context,
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
                spacing: 12.w,
                children: [
                  Text(
                    'Next'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              borderColor: Colors.transparent,
              onTap: controller.isLoading.value
                  ? null
                  : controller.submitEmailOrPhone,
            )),
            SizedBox(height: 38.h),
          ],
        ),
      ),
    );
  }
}
