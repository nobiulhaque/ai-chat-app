import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import '../../../../core/services/api_services/api_service.dart';

class ResetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  String? token;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args != null) {
      token = args['token'];
    }

    debugPrint("🔐 ResetPasswordController Initialized");
    debugPrint("📌 Received Token: $token");
  }

  void resetPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    debugPrint("🔍 Password Entered: $password");
    debugPrint("🔍 Confirm Password: $confirmPassword");

    if (password != confirmPassword) {
      debugPrint("❌ Passwords do NOT match");
      Get.snackbar(
        "Error",
        "Passwords do not match",

      );
      return;
    }

    if (token == null || token!.isEmpty) {
      debugPrint("❌ Token Missing / NULL");
      Get.snackbar(
        "Error",
        "Token not found. Please try again.",

      );
      return;
    }

    debugPrint("🚀 Making API Request with RAW Token (no Bearer): $token"); // ⬅️

    try {
      isLoading.value = true;

      final response = await ApiService().post(
        path: "/auth/reset-password",
        data: {
          "password": password,
        },
        token: token,
          rawToken: true
      );

      debugPrint("📥 API Response: $response");
      isLoading.value = false;

      if (response != null && response['success'] == true) {
        debugPrint("✅ Password Reset Successful");

        Get.dialog(
          AlertDialog(
            backgroundColor: AppColors.black,
            title: Center(
              child: Text(
                "✅ Success",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            content: Text(
              response['message'] ?? "Password reset successfully!",
              style: TextStyle(color: AppColors.white),
            ),
          ),
          barrierDismissible: false,
        );

// Auto close + navigate
        Future.delayed(Duration(seconds: 2), () {
          if (Get.isDialogOpen!) {
            Get.back(); // close dialog
          }
          Get.offAllNamed(Routes.SPLASH); // navigate
        });





      } else {
        debugPrint("❌ API Error: ${response?['message']}");

        Get.snackbar(
          "Error",
          response?['message'] ?? "Password reset failed",

        );
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("🔥 Exception Caught: $e");

      Get.snackbar(
        "Error",
        e.toString(),

      );
    }
  }

  @override
  void onClose() {
    debugPrint("🧹 ResetPasswordController Closed");
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
