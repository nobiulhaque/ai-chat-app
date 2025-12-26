import 'package:get/get.dart';

import '../controllers/payments_modules_controller.dart';

class PaymentsModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentsModulesController>(
      () => PaymentsModulesController(),
    );
  }
}
