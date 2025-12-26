import 'package:get/get.dart';

import '../controllers/replay_with_confidence_modules_controller.dart';

class ReplayWithConfidenceModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReplayWithConfidenceModulesController>(
      () => ReplayWithConfidenceModulesController(),
    );
  }
}
