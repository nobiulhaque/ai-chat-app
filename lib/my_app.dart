import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'core/theme/app_theme.dart';
import 'lang/translation_service.dart';

void main() async {



}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Social AI Wizard",
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,

          // Localization
          translations: TranslationService(),
          locale: locale,
          fallbackLocale: const Locale('en', 'US'),

          // Routes
          initialRoute: Routes.SPLASH,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
