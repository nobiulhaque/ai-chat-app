// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../views/bti_output_bottom_sheet.dart';

class BreakTheIceSmoothModulesController extends GetxController {
  static BreakTheIceSmoothModulesController get to => Get.find();

  // ------------------------
  // Mood List & Selection
  // ------------------------
  final List<String> moods = [
    'Would you rather',
    'What is something that',
    'In a situation where',
    'How would you handle',
  ];

  final RxString selectedMood = ''.obs;

  void changeMood(String mood) {
    selectedMood.value = mood;
  }

  // ------------------------
  // Personalize Text & Context
  // ------------------------
  final TextEditingController personalizeController = TextEditingController();
  final RxBool isContextAdded = false.obs;
  final RxString savedContext = ''.obs;

  void saveContext() {
    savedContext.value = personalizeController.text.trim();
    isContextAdded.value = savedContext.value.isNotEmpty;
  }

  void clearSavedContext(){
    savedContext.value = '';
    isContextAdded.value = false;
    personalizeController.clear();
    pickedImage.value = null;
  }

  void clearPersonalize() {
    personalizeController.clear();
    savedContext.value = '';
    isContextAdded.value = false;
  }

  // ------------------------
  // File Parameter
  // ------------------------
  final RxString selectedFilePath = ''.obs;
  final RxBool isFileSelected = false.obs;
  final RxString selectedFileName = ''.obs;




  //here we are using image picker

  // Future<void> pickFile() async {
  //   try {
  //     print("🔍 File Picker Starting...");
  //
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['png', 'jpg', 'jpeg', 'webp', 'heic', 'heif'],
  //       allowMultiple: false,
  //     );
  //
  //     print("📂 File Picker Result: $result");
  //
  //     if (result != null) {
  //       selectedFilePath.value = result.files.single.path ?? '';
  //       selectedFileName.value = result.files.single.name;
  //       isFileSelected.value = true;
  //
  //       pickedImage.value = File(result.files.single.path!);
  //
  //       print("✅ File Selected!");
  //       print("📁 File Path: ${selectedFilePath.value}");
  //       print("📄 File Name: ${selectedFileName.value}");
  //       print("✓ isFileSelected: ${isFileSelected.value}");
  //
  //       Get.snackbar(
  //         'Success',
  //         'File selected: ${selectedFileName.value}',
  //       );
  //     } else {
  //       print("❌ No file selected (user cancelled)");
  //     }
  //   } catch (e) {
  //     print("❌ File Picker Error: $e");
  //     Get.snackbar(
  //       'Error',
  //       'Failed to pick file: $e',
  //     );
  //   }
  // }

  void clearSelectedFile() {
    selectedFilePath.value = '';
    selectedFileName.value = '';
    isFileSelected.value = false;
  }

  // ========== FILE PICKER SECTION END ==========

  // ========== IMAGE PICKER SECTION ==========

  /// image file
  Rx<File?> pickedImage = Rx<File?>(null);

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      print("🔍 Image Picker Starting...");

      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      print("📂 Image Picker Result: $pickedFile");

      if (pickedFile != null) {
        selectedFilePath.value = pickedFile.path;
        selectedFileName.value = pickedFile.name;
        isFileSelected.value = true;

        pickedImage.value = File(pickedFile.path);

        print("✅ Image Selected!");
        print("📁 Image Path: ${selectedFilePath.value}");
        print("📄 Image Name: ${selectedFileName. value}");
        print("✓ isFileSelected: ${isFileSelected.value}");

        Get.snackbar(
          'Success',
          'Image selected: ${selectedFileName.value}',
        );
      } else {
        print("❌ No image selected (user cancelled)");
      }
    } catch (e) {
      print("❌ Image Picker Error: $e");
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
      );
    }
  }

  void clearSelectedImage() {
    selectedFilePath. value = '';
    selectedFileName. value = '';
    isFileSelected.value = false;
  }
  // ========== IMAGE PICKER SECTION END ==========

  // ------------------------
  // Loading & Output
  // ------------------------
  final RxBool isLoading = false.obs;
  final RxString outputText = ''.obs;

  // ------------------------
  // Call Chatbot API
  // ------------------------
  Future<void> callChatbotApi() async {
    try {
      print("🚀 Calling Chatbot API...");

      var headers = {'Accept': 'application/json'};

      var data = FormData.fromMap({
        'mode': 'mode2',
        'opener_type': selectedMood.value,
        'context': savedContext.value,
      });

      // Add file if selected
      if (selectedFilePath.value.isNotEmpty) {
        print("📎 Adding file to request: ${selectedFileName.value}");
        data.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(
              selectedFilePath.value,
              filename: selectedFileName.value,
            ),
          ),
        );
        print("✅ File added to FormData");
      } else {
        print("⚠️ No file selected");
      }

      var dio = Dio();
      print("📤 Sending API Request...");

      var response = await dio.request(
        'http://206.162.244.175:8056/api/chatbot/chat',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      print("------ API REQUEST ------");
      print("Mode: mode2");
      print("Opener Type: ${selectedMood.value}");
      print("Context: ${savedContext.value}");
      if (selectedFilePath.value.isNotEmpty) {
        print("File: ${selectedFileName.value}");
      }

      print("------ API RESPONSE: ------");
      if (response.statusCode == 200) {
        final data = response.data;
        String replyText = '';

        if (data is Map && data.containsKey('reply')) {
          replyText = data['reply'].toString();
        } else {
          replyText = data.toString();
        }

        print("✅ API Success!");
        print(replyText);
        outputText.value = replyText;
      } else {
        print("❌ API Error: ${response.statusMessage}");
        outputText.value = 'Error: ${response.statusMessage}';
      }
    } catch (e) {
      print("❌ API ERROR: $e");
      outputText.value = 'API Error: $e';
    }
  }

  // ------------------------
  // Handle Button Tap
  // ------------------------
  Future<void> handleChatbotButtonTap(BuildContext context) async {
    if (selectedMood.value.isEmpty) {
      Get.snackbar(
        'Mood not selected',
        'Please select a mood before proceeding',
      );
      return;
    }

    if (savedContext.value.isEmpty) {
      Get.snackbar(
        'Context not added',
        'Please add context before proceeding',
      );
      return;
    }

    isLoading.value = true;

    // Open bottom sheet
    showBtiOutputSheet(context, this);

    // Call API
    await callChatbotApi();

    isLoading.value = false;
  }

  // ------------------------
  // Cleanup
  // ------------------------
  @override
  void onClose() {
    personalizeController.dispose();
    super.onClose();
  }
}


