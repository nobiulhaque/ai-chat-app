import 'package:get/get.dart';

import '../controllers/handle_the_curveballs_controllers.dart';

class HandleTheCurveballsModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HandleTheCurveballsController>(
      () => HandleTheCurveballsController(),
    );
  }
}
