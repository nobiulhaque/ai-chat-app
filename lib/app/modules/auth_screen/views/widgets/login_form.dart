import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/auth_screen/controllers/auth_screen_controller.dart';

import 'package:social_wizard_app/app/modules/auth_screen/controllers/login_controller.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';

import '../../../../../core/utils/utils.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.authScreenController,});

  final AuthScreenController authScreenController;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Utils.customTextField(
              controller: controller.emailController,
              validator: authScreenController.validateEmail,
              context: context,
              title: "Email".tr,
              hintText: 'Enter Your Email or Phone'.tr,
            ),
            SizedBox(height: 36.h),
            Utils.customTextField(
              controller: controller.passwordController,
              context: context,
              title: "Password".tr,
              hintText: 'Enter Your Password'.tr,
              // validator: authScreenController.validatePassword
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(Routes.VERIFY_EMAIL_OR_PHONE);
                },
                child: Text(
                  'Forgot Password?'.tr,
                  style: Theme.of(context,).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.appRed
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Obx(()=>Utils.primaryButton(
                context: context,
                borderColor: Colors.transparent,
                child: controller.isLoading.value ? SpinKitThreeBounce(color: Colors.white, size: 12.0.r) : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12.w,
                  children: [
                    Text('Log in'.tr,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500
                    ),),
                    Icon(Icons.arrow_forward,)
                  ],
                ),
                onTap: controller.isLoading.value? null : (){
                  FocusScope.of(context).unfocus();  // Hides the keyboard
                  controller.login();

                }
            ),),
            SizedBox(height: 50.h),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Don’t have an account? '.tr,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                      text: 'Signup'.tr,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          authScreenController.selectedIndex.value = 1;
                        }
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
