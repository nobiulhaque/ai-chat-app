import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:social_wizard_app/app/modules/replay_with_confidence/controllers/replay_with_confidence_modules_controller.dart';
import 'package:social_wizard_app/app/modules/replay_with_confidence/views/widgets/rwc_bottom_sheet.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../shared_widgets/custom_bottom_sheet_with_button.dart';
import '../../break_the_ice_smooth/views/widgets/button_selector_outline_button.dart';
import '../../handle_the_curveballs/views/widgets/custom_appbar.dart';

class ReplayWithConfidenceModulesView
    extends GetView<ReplayWithConfidenceModulesController> {
  const ReplayWithConfidenceModulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        firstImage: 'assets/icons/face.png',
        secondImage: 'assets/icons/notes.png',
        onBackPressed: () => Get.back(),
      ),
      body: const ReplayWithConfidenceBody(),
    );
  }
}

class ReplayWithConfidenceBody extends StatefulWidget {
  const ReplayWithConfidenceBody({super.key});

  @override
  State<ReplayWithConfidenceBody> createState() =>
      _ReplayWithConfidenceBodyState();
}

class _ReplayWithConfidenceBodyState extends State<ReplayWithConfidenceBody> {
  late final ReplayWithConfidenceModulesController controller;
  late FocusNode theirMessageFocus;
  late FocusNode writeBackFocus;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ReplayWithConfidenceModulesController>()) {
      Get.put(ReplayWithConfidenceModulesController());
    }
    controller = Get.find();
    theirMessageFocus = FocusNode();
    writeBackFocus = FocusNode();
  }

  @override
  void dispose() {
    theirMessageFocus.dispose();
    writeBackFocus.dispose();
    super.dispose();
  }

  void _showCustomBottomSheet() {
    final TextEditingController textController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
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
                    controller: textController,
                    maxLines: 5,
                    maxLength: 300,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText:
                      "Tired of texting? Take the conversation to dinner.".tr,
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
            buttonText: "Abracadabra!✨ 2",
            onButtonPressed: () {
              controller.saveContext(textController.text);
              Get.back();
            },
            buttonColor: Colors.orange,
            buttonTextColor: Colors.black,
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Obx((){
              final image = controller.pickedImage.value;
              if(image !=null){
                return Column(
                  children: [
                    Image.file(image,width: double.infinity,height: 350.h,),
                    SizedBox(height: 20.h,)
                  ],
                );
              }
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(controller.chatList.isEmpty)
                    Text(
                      'Write something...'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )else
                    SizedBox.shrink(),
                  const SizedBox(height: 12),

                  Obx(() {
                    return Column(
                      children: List.generate(controller.chatList.length, (index){
                        final msg = controller.chatList[index];
                        return Align(
                          alignment: msg['type'] == 'their'
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.secondaryColor.withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    msg['message']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,

                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    controller.chatList.removeAt(index);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    size: 16.r,
                                    color: AppColors.appRed.withAlpha(200),
                                    semanticLabel: 'Delete message',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.theirMessageController,
                          focusNode: theirMessageFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            controller.submitTheirMessage();
                            writeBackFocus.requestFocus();
                          },
                          maxLines: 2,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Their message...'.tr,
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w400),
                            filled: true,
                            fillColor: Colors.grey[900],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey[700]!,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey[700]!,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: controller.writeBackController,
                          focusNode: writeBackFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            controller.submitMyReply();
                            theirMessageFocus.requestFocus();
                          },
                          maxLines: 2,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Write Back...'.tr,
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w400),
                            filled: true,
                            fillColor: Colors.grey[900],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey[700]!,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey[700]!,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(
                    'Reminder: Check that the last message in the conversation is from your contact.'
                        .tr,
                    style: TextStyle(color: Colors.orange[700], fontSize: 12),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              );
            }),

            Text(
              'Set Your Mood'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              return HorizontalChipSelector(
                items: controller.moods,
                selectedItem: controller.selectedMood.value,
                onItemSelected: (mood) {
                  controller.selectedMood.value = mood;
                },
              );
            }),
            const SizedBox(height: 24),
            Text(
              'Personalize Your Reply'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              return OutlinedActionButton(
                onPressed: _showCustomBottomSheet,
                icon: controller.isContextAdded.value ? Icons.check : Icons.add,
                label: controller.isContextAdded.value
                    ? 'Context added successfully'
                    : 'Add context'.tr,
              );
            }),
            const SizedBox(height: 24),
            PrimaryActionButtonchat(
              onPressed: () async {
                controller.isLoading.value = true;
                rwcshowApiOutputBottomSheet(context);
                await controller.sendLatestChatToApi();
                controller.isLoading.value = false;
              },
              label: "Abracadabra!✨ 1",
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
