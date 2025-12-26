import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/routes/app_pages.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/urls/urls.dart';

import '../../../../core/services/api_services/api_exception.dart';
import '../../../../core/services/api_services/api_service.dart';

class SignupController extends GetxController{
  final ApiService _apiService = ApiService();

  /// Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// observable states
  final isLoading = false.obs;

  /// Sign up method
  Future<void> signUp() async {
    if (isLoading.value) return; // Prevent double tap
    if (!formKey.currentState!.validate()) return; // validate form

    isLoading.value = true; // start loading

    try {
      /// prepare request data
      final requestBody = {
        'name': nameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };

      /// Call API
      final response = await _apiService.post<Map<String, dynamic>>(
        path: Urls.signUp,
        data: requestBody,
      );

      debugPrint('Sign up response: $response');

      /// Handle successful response
      if(response!['success'] == true ){
        // Show success message
        Get.snackbar(
          'Success',
          response['message'] ?? 'Account created successfully!',
        );

        // Navigate to home or login
        Get.offAllNamed(Routes.ONBOARDING);

        // if (response['token'] != null) {
        //   // User is automatically logged in
        //
        // }

        nameController.clear();
        emailController.clear();
        passwordController.clear();

        isLoading.value = false;
      }
    }on ApiException catch (e) {
      debugPrint('API Exception: ${e.message} | Status: ${e.statusCode} | Data: ${e.data}');
      // debugPrint("Final URL: ${ApiService()._dio.options.baseUrl}${Urls.signUp}");

      String errorMsg = 'Sign up failed';

      if (e.data is Map<String, dynamic>) {
        final data = e.data as Map<String, dynamic>;

        // Handle Laravel-style validation errors
        if (data.containsKey('errors') && data['errors'] is Map) {
          final errors = data['errors'] as Map<String, dynamic>;
          errorMsg = errors.values.first is List
              ? (errors.values.first as List).first.toString()
              : errors.values.first.toString();
        }
        // Fallback to message field
        else if (data['message'] != null) {
          errorMsg = data['message'].toString();
        }
      } else {
        errorMsg = e.message;
      }

      Get.snackbar(
        'Sign Up Failed',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.appRed,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }  catch (e, s) {
      debugPrint('Unexpected error: $e\nStacktrace: $s');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
      );
    } finally {
      // Stop loading
      isLoading.value = false;
    }

  }


  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}
