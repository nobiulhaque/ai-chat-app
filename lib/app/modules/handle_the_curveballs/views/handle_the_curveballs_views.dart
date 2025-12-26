import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../controllers/handle_the_curveballs_controllers.dart';

class HandleTheCurveballsViews extends StatelessWidget {
   HandleTheCurveballsViews({super.key});
  final HandleTheCurveballsController controller =
  Get.put(HandleTheCurveballsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with language and menu
            Padding(
              padding: const EdgeInsets.only(top: 12, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/icons/flag.jpg',
                    width: 24,
                    height: 16,
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),

            // Full screen scrollable content including logo
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Logo section
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/images/appLogo.png',
                      width: 152,
                      height: 142,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
