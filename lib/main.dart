import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:social_wizard_app/core/services/storage_services/storage_service.dart';
import 'package:social_wizard_app/my_app.dart';

import 'app/modules/home/controllers/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await StorageService().init();

  // // Initialize storage
  // await GetStorage.init();

  // Load HomeController before app runs
  final HomeController homeController = Get.put(HomeController());

  final savedLang = homeController.selectedLanguage.value;
  final savedCountry = homeController.languages[savedLang]!['country']!;

  runApp(MyApp(
    locale: Locale(savedLang, savedCountry),
  ));
}
