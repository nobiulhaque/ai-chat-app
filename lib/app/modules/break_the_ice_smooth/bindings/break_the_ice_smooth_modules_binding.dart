import 'package:get/get.dart';

import '../controllers/break_the_ice_smooth_modules_controller.dart';

class BreakTheIceSmoothModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BreakTheIceSmoothModulesController());
  }
}