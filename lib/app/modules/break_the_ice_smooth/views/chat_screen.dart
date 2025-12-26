import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/break_the_ice_smooth/views/widgets/middle_text_content.dart';
import 'package:social_wizard_app/app/modules/break_the_ice_smooth/views/widgets/mode_selector.dart';
import 'package:social_wizard_app/app/modules/handle_the_curveballs/views/widgets/custom_appbar.dart';
import 'package:social_wizard_app/core/utils/utils.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../shared_widgets/custom_bottom_sheet_with_button.dart';
import '../controllers/break_the_ice_smooth_modules_controller.dart';

class BreakTheIceSmoothChatView extends StatelessWidget {
  BreakTheIceSmoothChatView({super.key});
  final controller = Get.put(BreakTheIceSmoothModulesController());
  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CustomBottomSheetWidgets(
          title: "Personalize".tr,
          subtitle: "Tell me everything you want me to consider".tr,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[800]!, width: 1),
                ),
                child: TextField(
                  controller: controller.personalizeController,
                  maxLines: 5,
                  maxLength: 300,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText:
                        "Tired of texting? Take the conversation to dinner. "
                            .tr,
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                    counterStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          buttonText: "Abracadabra!  ✨ 2",
          onButtonPressed: () {
            controller.saveContext();
            Navigator.pop(context);
          },
          buttonColor: Colors.orange,
          buttonTextColor: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        firstImage: 'assets/icons/face.png',
        secondImage: 'assets/icons/messages.png',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final image = controller.pickedImage.value;
                if(image != null){
                 return Column(
                   children: [
                     Image.file(image,width: double.infinity,height: 350.h,),
                     SizedBox(height: 20.h,)
                   ],
                 );
                }
                return Column(
                  children: [
                    const StepsWidget(),
                    SizedBox(height: 110.h),
                  ],
                );

              }),

              _buildSectionTitle('Set the mood'.tr),
              SizedBox(height: 10.h),
              ModeSelector(),
              SizedBox(height: 30.h),
              _buildSectionTitle('Personalize (million user)'.tr),
              SizedBox(height: 10.h),
              _buildContextButton(context),
              SizedBox(height: 10.h),
              _buildActionButton(context),
              SizedBox(height: 56.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _buildContextButton(BuildContext context) => Obx(() {
    final isAdded = controller.isContextAdded.value;

    return OutlinedButton.icon(
      onPressed: () => _showCustomBottomSheet(context),
      icon: Icon(
        isAdded ? Icons.check : Icons.add,
        color: const Color(0xFFF59E0B),
        size: 20,
      ),
      label: Text(
        isAdded ? 'Context added successfully' : 'Add context',
        style: const TextStyle(color: Color(0xFFF59E0B)),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFF59E0B)),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  });

  Widget _buildActionButton(BuildContext context) => Utils.primaryButton(
    context: context,
    title: 'Abracadabra!  ✨ 1'.tr,
    textColor: Colors.black,
    backgroundColor: AppColors.secondaryColor,
    height: 48.h,
    onTap: () => controller.handleChatbotButtonTap(context),
  );
}
