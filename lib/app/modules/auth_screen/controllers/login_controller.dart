import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/api_services/api_exception.dart';
import '../../../../core/services/api_services/api_service.dart';
import '../../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController{

  final ApiService _apiService = ApiService();

  /// Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// observable states
  final isLoading = false.obs;

  Future<void> login() async {
    if (isLoading.value) return; // Prevent double tap
    if (!formKey.currentState!.validate()) return; // validate form

    isLoading.value = true; // start loading

    try {
      /// prepare request data
      final requestBody = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };

      /// Call API
      final response = await _apiService.post<Map<String, dynamic>>(
        path: Urls.login,
        data: requestBody,
      );

      debugPrint('Login response: $response');

      /// Handle successful response
      if (response!['success'] == true) {
        final token = response['data']['token'];
        debugPrint('\n\nSaved token: $token');

        if (token == null) {
          throw "Token missing in response!";
        }

        // Save token
        await _apiService.saveToken(token);


        // Navigate to home
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Login Failed", response['message'] ?? "Unknown error");
      }

        emailController.clear();
        passwordController.clear();

        isLoading.value = false;


    }on ApiException catch (e) {
      debugPrint('API Exception: ${e.message} | Status: ${e.statusCode} | Data: ${e.data}');
      // debugPrint("Final URL: ${ApiService()._dio.options.baseUrl}${Urls.signUp}");

      String errorMsg = 'Login failed';

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
        'Login Failed',
        errorMsg,
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }



}