import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';
import '../../../../core/services/api_services/api_service.dart';

class VerifyEmailController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void submitEmailOrPhone() async {
    final emailOrPhone = emailController.text.trim();

    if (emailOrPhone.isEmpty) {
      Get.snackbar("Error", "Please enter your email ");
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiService().post(
        path: "/otp/send",
        data: {"email": emailOrPhone},
      );

      isLoading.value = false;

      if (response != null && response['success'] == true) {
        Get.snackbar("Success", response['message'] ?? "OTP sent successfully!");

        Get.toNamed(Routes.VERIFY_OTP, arguments: {"email": emailOrPhone});
      } else {
        Get.snackbar("Error", response['message'] ?? "Something went wrong!");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
