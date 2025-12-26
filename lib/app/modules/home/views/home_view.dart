// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/home/localization_alert_dialog/language_selection_dialog.dart';
import 'package:social_wizard_app/app/modules/home/views/menu_bottomsheet.dart';
import 'package:social_wizard_app/app/modules/replay_with_confidence/controllers/replay_with_confidence_modules_controller.dart';
import 'package:social_wizard_app/app/shared_widgets/cappbar.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../shared_widgets/custom_bottom_sheet_without_button.dart';
import '../../break_the_ice_smooth/controllers/break_the_ice_smooth_modules_controller.dart';
import '../../break_the_ice_smooth/views/chat_screen.dart';
import '../../handle_the_curveballs/views/chat_screen.dart';
import '../../handle_the_curveballs/views/widgets/feature_card_button.dart';

import '../../replay_with_confidence/views/replay_with_confidence_modules_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // Updated Bottom Sheet Function (Flexible Buttons)
  void openCustomBottomSheet(
    BuildContext context,
    List<Map<String, dynamic>> buttons,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SimpleBottomSheet(
          title: "Select Option".tr,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              ...buttons.map(
                (btn) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 52,
                      minWidth: double.infinity, // auto-flex full width
                    ),
                    child: ElevatedButton(
                      onPressed: btn['onPressed'],
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              btn['text'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(btn['icon'], width: 20, height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LanguageSelectionDialog(
        onLanguageSelected: (languageCode) {
          controller.updateLanguage(languageCode);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final replayWithConfidenceController = Get.put(
      ReplayWithConfidenceModulesController(),
    );
    Get.put(BreakTheIceSmoothModulesController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: Cappbar(
          onFlagTap: () {
            _showLanguageDialog(context);
          },
          onMenuTap: () {
            showBottomSheetHome(context);
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Image.asset(
                        'assets/images/appLogo.png',
                        width: 152,
                        height: 142,
                      ),
                      const SizedBox(height: 16),

                      FeatureCardButton(
                        title: 'Reply with confidence 💬'.tr,
                        subtitle:
                            'Screenshot the chat. We\'ll tell you exactly what to say.'.tr,
                        iconPath: 'assets/icons/writing.png',
                        bottomText:
                            'Instant replies that actually sound like you 💡'
                                .tr,
                        backgroundColor: const Color(0x267A42FF),
                        onTap: () {
                          openCustomBottomSheet(context, [
                            {
                              'text': 'Start typing...'.tr,
                              'icon': 'assets/icons/headcartoon.png',
                              'onPressed': () {
                                Get.back();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReplayWithConfidenceModulesView(),
                                  ),
                                );
                              },
                            },
                            {
                              'text': 'Add screenshot to analyze chat'.tr,
                              'icon': 'assets/icons/image.png',
                              'onPressed': () async {
                                await replayWithConfidenceController.pickImage();
                                // if (replayWithConfidenceController
                                //     .isFileSelected
                                //     .value) {
                                //   print("✅ File selected and ready to send");
                                //   Get.back(); // Close bottom sheet
                                //   Get.to(
                                //     () => ReplayWithConfidenceModulesView(),
                                //   );
                                // } else {
                                //   print("❌ No file selected (user cancelled)");
                                // }
                                // Check if the widget is still mounted before using context
                                if (!context.mounted) return;

                                Navigator.pop(context);
                                Get.to(
                                      () => ReplayWithConfidenceModulesView(),
                                );
                              },
                            },
                          ]);
                        },
                      ),

                      const SizedBox(height: 12),

                      FeatureCardButton(
                        title: 'Break the ice smooth 🔥'.tr,
                        subtitle:
                            'Perfect openers based on her profile. No more \'hey\' texts.'
                                .tr,
                        iconPath: 'assets/icons/Conversation.png',
                        bottomText: 'Start strong, keep it going 💡'.tr,
                        backgroundColor: const Color(0x26FFD36E),
                        onTap: () {
                          openCustomBottomSheet(context, [
                            {
                              'text': 'Cute pickup lines✨'.tr,
                              'icon': 'assets/icons/blockgame.png',
                              'onPressed': () {
                                Get.back();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BreakTheIceSmoothChatView(),
                                  ),
                                );
                              },
                            },
                            {
                              'text': 'Add screenshot to analyze chat'.tr,
                              'icon': 'assets/icons/image.png',
                              'onPressed': () async {
                                // await BreakTheIceSmoothModulesController.to.pickImage();
                                await BreakTheIceSmoothModulesController.to.pickImage();

                                // if (BreakTheIceSmoothModulesController
                                //     .to
                                //     .isFileSelected
                                //     .value) {
                                //   print(
                                //     "✅ File Selected: ${BreakTheIceSmoothModulesController.to.selectedFileName.value}",
                                //   );
                                //   Get.back(); // Close bottom sheet
                                //   Get.to(() => BreakTheIceSmoothChatView());
                                // } else {
                                //   print("❌ No file selected (user cancelled)");
                                // }
                                // Check if the widget is still mounted before using context
                                if (!context.mounted) return;

                                Navigator.pop(context);
                                Get.to(() => BreakTheIceSmoothChatView());


                              },
                            },
                          ]);
                        },
                      ),

                      const SizedBox(height: 12),

                      FeatureCardButton(
                        title: 'Handle the curveballs 🔥'.tr,
                        subtitle:
                            'She said something weird? We\'ll help you recover like a pro.'
                                .tr,
                        iconPath: 'assets/icons/headcartoon.png',
                        bottomText: 'Save yourself from the awkward 💡'.tr,
                        backgroundColor: const Color(0x26FF4F81),
                        onTap: () {
                          Get.to(() => HandleTheCurveballsScreen());
                        },
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
