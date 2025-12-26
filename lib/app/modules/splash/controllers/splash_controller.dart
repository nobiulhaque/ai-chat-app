import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/services/storage_services/storage_service.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  void checkAndNavigate() {
    Future.delayed(const Duration(seconds: 2), () async {
      // final api = ApiService();
      // final token = await api.getValidToken();

      final storage = StorageService();
      final seenOnboarding = storage.isOnboardingSeen;

      debugPrint('\n\n\n =========== onboarding seen: $seenOnboarding');

      if(seenOnboarding == false){
        Get.offAllNamed(Routes.ONBOARDING);
      }else{
        Get.offAllNamed(Routes.HOME);
      }

        // if (token != null) {
        //   Get.offAllNamed(Routes.HOME);
        // } else {
        //   // await api.logout(); // Clear any stale token
        //   Get.offAllNamed(Routes.AUTH_SCREEN);
        // }
      }
    );
  }
}


// @override
// void onInit() {
//   super.onInit();
//   checkLoginStatus();
// }
//
// Future<void> checkLoginStatus() async {
//   final token = await _api.getValidToken();
//
//   if (token != null) {
//     // Token exists AND still valid
//     Get.offAllNamed(Routes.HOME);
//   } else {
//     // No token OR expired token
//     Get.offAllNamed(Routes.LOGIN);
//   }
// }