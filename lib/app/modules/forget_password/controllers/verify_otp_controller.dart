import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/api_services/api_service.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';

class VerifyOtpController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;
  String? emailOrPhone;

  void verifyOtp() async {
    final otpText = otpController.text.trim();

    if (otpText.isEmpty || otpText.length != 6) {
      Get.snackbar("Error", "Please enter a valid 6-digit code");
      return;
    }

    final otpValue = int.tryParse(otpText);

    if (otpValue == null) {
      Get.snackbar("Error", "Invalid OTP format");
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiService().post(
        path: "/otp/verify",
        data: {
          "email": emailOrPhone,
          "otp": otpValue,
        },
      );

      isLoading.value = false;

      if (response != null && response['success'] == true) {

        final resetPasswordToken = response['data']['token'];

        // 🔍 Debug print
        debugPrint("🔑 OTP Token Received: $resetPasswordToken");

        // 🔐 Save token if needed
        await ApiService().saveToken(resetPasswordToken);

        Get.snackbar("Success", "OTP Verified Successfully!");

        // ✅ Navigate to reset password with token
        Get.toNamed(
          Routes.RESET_PASSWORD,
          arguments: {
            "token": resetPasswordToken,
            "email": emailOrPhone,
          },
        );

      } else {
        Get.snackbar("Error", response['message'] ?? "Invalid OTP");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
