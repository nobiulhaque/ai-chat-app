import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/auth_screen/controllers/auth_screen_controller.dart';

import 'package:social_wizard_app/app/modules/auth_screen/controllers/signup_controller.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';

import '../../../../../core/utils/utils.dart';


class SignupForm extends StatelessWidget {
   const SignupForm({super.key, required this.authScreenController, });

   final AuthScreenController authScreenController;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Utils.customTextField(
              controller: controller.nameController,
              context: context,
              title: "Name".tr,
              hintText: 'Enter Your Name'.tr,
              validator: authScreenController.validateName
            ),
            SizedBox(height: 30.h),
            Utils.customTextField(
              controller: controller.emailController,
              context: context,
              title: "Email".tr,
              hintText: 'Enter Your Email or Phone'.tr,
              validator: authScreenController.validateEmail
            ),
            SizedBox(height: 30.h),
            Utils.customTextField(
              controller: controller.passwordController,
              context: context,
              title: "Password".tr,
              hintText: 'Enter Your Password'.tr,
              validator: authScreenController.validatePassword
            ),
            SizedBox(height: 36.h),
            Obx(()=>Utils.primaryButton(
              context: context,
              child: controller.isLoading.value ? SpinKitThreeBounce(color: Colors.white, size: 12.0.r) : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12.w,
                children: [
                  Text(
                    'Signup',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              borderColor: Colors.transparent,
              onTap: controller.isLoading.value ? null : (){
                FocusScope.of(context).unfocus();  // Hides the keyboard
                controller.signUp();
              }
            ),),
            SizedBox(height: 50.h),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Already have an account? '.tr,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: 'Login'.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        authScreenController.selectedIndex.value = 0;
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
