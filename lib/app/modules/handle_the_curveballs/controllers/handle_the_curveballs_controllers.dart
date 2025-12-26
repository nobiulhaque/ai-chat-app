// ignore_for_file: invalid_use_of_protected_member, avoid_print, unnecessary_string_interpolations, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:social_wizard_app/app/modules/handle_the_curveballs/views/output_bottom_sheet.dart';

class HandleTheCurveballsController extends GetxController {
  // Dio instance
  final Dio _dio = Dio();

  var isLoading = false. obs;
  var showNewChat = false.obs;

  // Mood list
  var moods = [
    'Casual',
    'Apologetic',
    'Encouraging',
    'Sarcastic',
    'Curious',
    'Flirty',
    'Empathetic',
    'Clap back',
    'Playful',
    'Assertive',
    'Nonchalant',
    'Serious',
  ].obs;

  // Selected mood
  var selectedMood = 'Casual'.obs;

  // Selected moods (multiple)
  var selectedMoods = <String>[]. obs;

  // Text controller
  final textController = TextEditingController();
  var textLength = 0.obs; // reactive length

  var mode = 'mode3'.obs;
  var situationDescription = ''.obs;

  final RxString outputText = ''.obs;

  // ✅ FILE/IMAGE PICKER PARAMETERS
  final RxString selectedFilePath = ''.obs;
  final RxBool isFileSelected = false.obs;
  final RxString selectedFileName = ''.obs;

  void cleatText() {
    textController.clear();
    selectedMood.value = '';
    selectedMoods.clear();
    selectedFilePath.value = '';
    selectedFileName.value = '' ;
    isFileSelected.value = false;
  }

  @override
  void onInit() {
    super.onInit();

    // Initial text
    textController.text = "";

    // Set initial length
    textLength. value = textController.text.length;

    // Update length reactively
    textController.addListener(() {
      textLength.value = textController.value.text.length;
    });
  }

  /* 
  // ========== FILE PICKER SECTION (COMMENTED OUT) ==========
  Future<void> pickFile() async {
    try {
      print("🔍 File Picker Starting...");

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'webp', 'heic', 'heif'],
        allowMultiple: false,
      );

      print("📂 File Picker Result: $result");

      if (result != null) {
        selectedFilePath.value = result.files. single.path ??  '';
        selectedFileName.value = result.files. single.name;
        isFileSelected.value = true;

        print("✅ File Selected!");
        print("📁 File Path: ${selectedFilePath.value}");
        print("📄 File Name: ${selectedFileName.value}");
        print("✓ isFileSelected: ${isFileSelected. value}");

        Get.snackbar(
          'Success',
          'File selected: ${selectedFileName.value}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("❌ No file selected (user cancelled)");
      }
    } catch (e) {
      print("❌ File Picker Error: $e");
      Get.snackbar(
        'Error',
        'Failed to pick file: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void clearSelectedFile() {
    selectedFilePath.value = '';
    selectedFileName.value = '';
    isFileSelected.value = false;
  }
  // ========== FILE PICKER SECTION END ==========
  */

  // ========== IMAGE PICKER SECTION ==========
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

        print("✅ Image Selected!");
        print("📁 Image Path: ${selectedFilePath.value}");
        print("📄 Image Name: ${selectedFileName. value}");
        print("✓ isFileSelected: ${isFileSelected.value}");

        Get.snackbar(
          'Success',
          'Image selected',
        );
      } else {
        print("❌ No image selected (user cancelled)");
      }
    } catch (e) {
      print("❌ Image Picker Error: $e");
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        backgroundColor: Colors. red,
        colorText: Colors.white,
      );
    }
  }

  void clearSelectedImage() {
    selectedFilePath.value = '';
    selectedFileName.value = '';
    isFileSelected.value = false;
  }
  // ========== IMAGE PICKER SECTION END ==========

  // Select mood (toggle)
  void selectMood(String mood) {
    if (selectedMoods.contains(mood)) {
      selectedMoods.remove(mood);
    } else {
      selectedMoods.add(mood);
    }
  }

  // Submit action with BuildContext
  void submit(BuildContext context) async {
    final text = textController.text;
    final moods = selectedMoods.value;

    // Validate input
    if (text.isEmpty) {
      Get.snackbar('Error', 'Please enter a message');
      return;
    }

    if (moods. isEmpty) {
      Get.snackbar('Error', 'Please select at least one mood');
      return;
    }

    // Print to terminal
    print('situation_description: $text');
    print('Selected Moods: $moods');
    print('Mode: ${mode.value}');
    if (selectedFilePath.value.isNotEmpty) {
      print('File: ${selectedFileName.value}');
    }

    // Call API and wait for completion
    await sendChatRequest(
      mode: mode.value,
      situationDescription: text,
      mood: moods.join(', '),
      filePath: selectedFilePath.value. isNotEmpty
          ? selectedFilePath.value
          : null,
    );

    // Show bottom sheet ONLY after API completes successfully
    if (outputText.value.isNotEmpty && !isLoading.value) {
      showOutputBottomSheet(context, this);
      showNewChat. value = true;
    }
  }

  Future<void> sendChatRequest({
    String?  mode,
    String? originalMessage,
    String? response,
    String? mood,
    String? personalContext,
    String? openerType,
    String? context,
    String? situationDescription,
    String? filePath, // ✅ NEW PARAMETER
  }) async {
    try {
      isLoading.value = true;

      final data = <String, dynamic>{};

      if (mode?. isNotEmpty == true) data['mode'] = mode;
      if (originalMessage?. isNotEmpty == true) {
        data['original_message'] = originalMessage;
      }
      if (response?.isNotEmpty == true) data['response'] = response;
      if (mood?.isNotEmpty == true) data['mood'] = mood;
      if (personalContext?. isNotEmpty == true) {
        data['personal_context'] = personalContext;
      }
      if (openerType?.isNotEmpty == true) {
        data['opener_type'] = openerType;
      }
      if (context?.isNotEmpty == true) data['context'] = context;
      if (situationDescription?.isNotEmpty == true) {
        data['situation_description'] = situationDescription;
      }

      // ✅ ADD FILE IF SELECTED
      if (filePath != null && filePath.isNotEmpty) {
        print("📎 Adding file to request: ${selectedFileName.value}");
        data['file'] = await MultipartFile.fromFile(
          filePath,
          filename: selectedFileName.value,
        );
        print("✅ File added to FormData");
      } else {
        print("⚠️ No file selected");
      }

      // Configure Dio
      _dio.options.baseUrl = 'http://206.162.244.175:8056';
      _dio.options. connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);

      print("📤 Sending API Request...");
      print("------ API REQUEST ------");
      print("Mode: $mode");
      print("Situation Description: $situationDescription");
      print("Moods: $mood");
      if (filePath != null && filePath.isNotEmpty) {
        print("File: ${selectedFileName.value}");
      }

      final res = await _dio.post(
        '/api/chatbot/chat',
        data: FormData. fromMap(data),
      );

      if (res.statusCode == 200) {
        print("------ API RESPONSE ------");
        print("✅ API Success!");
        // Success - extract 'reply' from response
        outputText.value = res.data['reply'] ?? res.data['result'] ?? 'No response';
        print('API Response: ${res.data}');
      } else {
        Get.snackbar('Error', 'Failed to process request');
        outputText.value = 'Error: ${res.statusCode}';
      }

      isLoading.value = false;
    } on DioException catch (e) {
      isLoading.value = false;
      _handleError(e);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong: $e');
      print('Error: $e');
    }
  }

  void _handleError(DioException e) {
    String message = 'Something went wrong';

    if (e.response != null) {
      message = e.response?. data['message'] ?? 'Server error';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      message = 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = 'Receive timeout';
    } else if (e.type == DioExceptionType.unknown) {
      message = 'Network error - please check your connection';
    }

    Get.snackbar('Error', message);
    print('DioException: $message');
  }

  // New Chat method
  void newChat() {
    // Clear input text
    textController.clear();
    textLength. value = 0;

    // Output
    outputText.value = '';

    // Clear selected moods
    selectedMoods.clear();

    // ✅ Clear file
    clearSelectedImage();

    // Reset to show Abracadabra button again
    showNewChat.value = false;
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}