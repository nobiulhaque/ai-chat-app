import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/auth_screen/views/widgets/auth_tab_bar.dart';
import 'package:social_wizard_app/app/modules/auth_screen/views/widgets/login_form.dart';
import 'package:social_wizard_app/app/modules/auth_screen/views/widgets/signup_form.dart';
import '../controllers/auth_screen_controller.dart';

class AuthScreenView extends GetView<AuthScreenController> {
  const AuthScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Align(
              alignment: AlignmentGeometry.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Obx(
                  () => AuthTabBar(
                    tabs: controller.authTabs,
                    selectedIndex: controller.selectedIndex.value,
                    onTabChanged: (value) {
                      controller.selectedIndex.value = value;
                    },
                  ),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: controller.selectedIndex.value == 0
                    ? LoginForm(authScreenController: controller)
                    : SignupForm(authScreenController: controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
