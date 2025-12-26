import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_wizard_app/app/modules/splash/controllers/splash_controller.dart';
import 'package:social_wizard_app/app/modules/splash/views/splash_view.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/constant/app_images.dart';

class MockSplashController extends GetxController implements SplashController {
  bool isCalled = false;

  @override
  void checkAndNavigate() {
    isCalled = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSplashController mockController;

  setUp(() {
    mockController = MockSplashController();
    Get.put<SplashController>(mockController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('SplashView renders logo and triggers navigation check',
          (WidgetTester tester) async {
        // ScreenUtil requires initialization with a layout size
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (_, __) => GetMaterialApp(
              home: const SplashView(),
            ),
          ),
        );

        // Allows post-frame callbacks to run
        await tester.pump();

        // 1️⃣ EXPECT LOGO IS FOUND
        final imageFinder = find.byType(Image);
        expect(imageFinder, findsOneWidget);

        final imageWidget = tester.widget<Image>(imageFinder);
        expect((imageWidget.image as AssetImage).assetName, AppImages.appLogo);

        // 2️⃣ EXPECT BACKGROUND COLOR IS BLACK
        final scaffoldFinder = find.byType(Scaffold);
        final scaffoldWidget = tester.widget<Scaffold>(scaffoldFinder);
        expect(scaffoldWidget.backgroundColor, AppColors.black);

        // 3️⃣ EXPECT checkAndNavigate() WAS CALLED
        expect(mockController.isCalled, true);
      });
}
