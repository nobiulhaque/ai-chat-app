import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/auth_screen/controllers/login_controller.dart';
import 'package:social_wizard_app/app/modules/auth_screen/controllers/signup_controller.dart';

import '../controllers/auth_screen_controller.dart';

class AuthScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthScreenController>(
      () => AuthScreenController(),
    );
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
    Get.lazyPut<SignupController>(
          () => SignupController(),
    );
  }
}
