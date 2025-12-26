// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/utils/utils.dart';
import '../controllers/handle_the_curveballs_controllers.dart';
import 'widgets/custom_appbar.dart';

class HandleTheCurveballsScreen extends StatelessWidget {
  HandleTheCurveballsScreen({super.key});

  final HandleTheCurveballsController controller = Get.put(
    HandleTheCurveballsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        firstImage: 'assets/images/appLogo.png',
        secondImage: 'assets/icons/face.png',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text input
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[800]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: controller.textController,
                              maxLines: null,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message...  '.tr,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Reactive counter
                            Obx(
                              () => Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '(${controller.textLength.value}/1000)',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
              // Set the mood title (non-reactive)
              Text(
                'Set the mood'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),

              // Mood selection (reactive - multiple)
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.moods.length,
                  itemBuilder: (context, index) {
                    final mood = controller.moods[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 11.w),
                      child: Obx(() {
                        final isSelected = controller.selectedMoods.contains(
                          mood,
                        );
                        return GestureDetector(
                          onTap: () {
                            controller.selectMood(mood);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey[900],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                mood,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Personalize title (non-reactive)
              const Text(
                'Personalize (million user)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 12),

              // Add photo button (non-reactive)
              Align(
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => OutlinedButton.icon(
                    onPressed: () async {
                      await controller.pickImage();
                    },
                    icon: Icon(
                      controller.isFileSelected.value ? Icons.check : Icons.add,
                      color: Colors.orange,
                      size: 18,
                    ),
                    label: Text(
                      controller.isFileSelected.value
                          ? 'Image added successfully'
                          : 'Add photo',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Single button that toggles between Abracadabra and New Chat
              Obx(
                () => Utils.primaryButton(
                  context: context,
                  title: controller.isLoading.value
                      ? 'Loading...'
                      : 'Abracadabra!  ✨ 1'.tr,
                  height: 48.h,
                  textColor: AppColors.black,
                  backgroundColor: AppColors.secondaryColor,
                  onTap: () {
                    controller.submit(context);
                  },
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
