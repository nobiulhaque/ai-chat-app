// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

class ReplayWithConfidenceModulesController extends GetxController {
  late TextEditingController theirMessageController;
  late TextEditingController writeBackController;

  final RxString selectedMood = 'Casual'.  obs;
  final RxList<Map<String, String>> chatList = <Map<String, String>>[]. obs;
  final RxString savedContext = ''.obs;
  final RxBool isContextAdded = false.obs;
  final RxBool isLoading = false.obs;
  final RxString outputText = ''.obs;

  final RxString selectedFilePath = ''.obs;
  final RxString selectedFileName = ''.obs;
  final RxBool isFileSelected = false.obs;
  Rx<File?> pickedImage = Rx<File?>(null);

  final ImagePicker _imagePicker = ImagePicker();
  final String apiUrl = 'http://206.162.244.175:8056/api/chatbot/chat';
  var mode = 'mode1';

  final List<String> moods = [
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
  ];

  @override
  void onInit() {
    super.onInit();
    theirMessageController = TextEditingController();
    writeBackController = TextEditingController();
  }

  @override
  void onClose() {
    theirMessageController.dispose();
    writeBackController.dispose();
    super.onClose();
  }

  // ==================== CHAT MANAGEMENT ====================
  void submitTheirMessage() {
    if (theirMessageController.text.isNotEmpty) {
      chatList.add({
        'type': 'their',
        'message': theirMessageController.text
      });
      theirMessageController.clear();
    }
  }

  void submitMyReply() {
    if (writeBackController.text.isNotEmpty) {
      chatList.add({
        'type': 'my',
        'message': writeBackController.text
      });
      writeBackController.clear();
    }
  }

  void clearChatList() {
    chatList.clear();
  }

  void printChatSummary() {
    print("\n===== CHAT SUMMARY =====");
    for (var msg in chatList) {
      print("${msg['type']}: ${msg['message']}");
    }
    print("Mood: ${selectedMood.value}");
    print("Context: ${savedContext.value.  isEmpty ? '(empty)' : savedContext.value}");
    print("========================\n");
  }

  // ==================== CONTEXT MANAGEMENT ====================
  void saveContext(String text) {
    savedContext.value = text;
    isContextAdded.value = true;
    print("✅ Context saved");
  }

  void clearContext() {
    savedContext.  value = '';
    isContextAdded.value = false;
    clearSelectedImage();
  }

  // ==================== IMAGE MANAGEMENT ====================
  Future<void> pickImage() async {
    try {
      print("🔍 Picking image...");
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        selectedFilePath.value = pickedFile.path;
        selectedFileName.  value = pickedFile.name;
        isFileSelected.value = true;
        pickedImage.value = File(pickedFile.path);

        print("✅ Image selected: ${selectedFileName.value}");
        // Get.snackbar(
        //   'Success',
        //   'Image selected: ${selectedFileName.value}',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else {
        print("❌ No image selected");
      }
    } catch (e) {
      print("❌ Image Picker Error: $e");
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        backgroundColor: Colors.  red,
        colorText: Colors.white,
      );
    }
  }

  void clearSelectedImage() {
    selectedFilePath. value = '';
    selectedFileName. value = '';
    isFileSelected.value = false;
    pickedImage.value = null;
  }

  // ==================== MESSAGE EXTRACTION ====================
  Map<String, String> _extractLatestMessages() {
    String originalMessage = '';
    String responseMessage = '';

    // Get LAST "their" message (OPTIONAL)
    try {
      final theirMsg = chatList.lastWhere(
        (msg) => msg['type'] == 'their',
        orElse: () => {},
      );
      originalMessage = theirMsg['message'] ?? '';
    } catch (e) {
      print("ℹ️ No 'their' message (optional)");
    }

    // Get LAST "my" message (OPTIONAL)
    try {
      final myMsg = chatList. lastWhere(
        (msg) => msg['type'] == 'my',
        orElse: () => {},
      );
      responseMessage = myMsg['message'] ??  '';
    } catch (e) {
      print("ℹ️ No 'my' message (optional)");
    }

    return {
      'originalMessage': originalMessage,
      'responseMessage': responseMessage,
    };
  }

  // ==================== VALIDATION ====================
  bool _validateBeforeAPI() {
    // ONLY mood is required
    if (selectedMood.value.isEmpty) {
      _showError('Please select a mood');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    print("❌ Error: $message");
    outputText.value = message;
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _showSuccess(String message) {
    print("✅ $message");
    // Get.snackbar(
    //   'Success',
    //   message,
    //
    // );
  }

  // ==================== API CALL ====================
  Future<Map<String, dynamic>?> _sendToApi({
    required String originalMessage,
    required String responseMessage,
    String?   filePath,
  }) async {
    try {
      print("\n📋 ===== API PAYLOAD =====");
      print("Mode: $mode");
      print("Original Message: ${originalMessage.  isEmpty ? '(empty)' : originalMessage}");
      print("Response Message: ${responseMessage. isEmpty ? '(empty)' : responseMessage}");
      print("Mood: ${selectedMood.value}");
      print("Personal Context: ${savedContext.value.  isEmpty ? '(empty)' : savedContext.value}");
      print("File: ${filePath != null ? selectedFileName.value : '(none)'}");
      print("===========================\n");

      // Build FormData
      var data = dio.FormData.  fromMap({
        'mode': mode,
        'original_message': originalMessage,
        'response': responseMessage,
        'mood': selectedMood.value.  toLowerCase(),
        'personal_context': savedContext.value,
      });

      // Add file if selected
      if (filePath != null && filePath.  isNotEmpty) {
        data.files.  add(
          MapEntry(
            'file',
            await dio.MultipartFile.fromFile(
              filePath,
              filename: selectedFileName.value,
            ),
          ),
        );
        print("📎 File added to request");
      }

      // Make request
      var client = dio.  Dio();
      print("📤 Sending request to API...");

      var response = await client.request(
        apiUrl,
        options: dio.Options(method: 'POST'),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ API Success!   Status: ${response.statusCode}");
        print("Response: ${json.encode(response.data)}");
        return response.data;
      } else {
        print("⚠️ Unexpected status: ${response.statusCode}");
        return null;
      }
    } on dio.DioException catch (e) {
      print("\n❌ ===== API ERROR =====");
      print("Status Code: ${e.response?.statusCode}");
      print("Message: ${e.message}");

      if (e.response != null) {
        try {
          if (e.response!.data is Map) {
            print("Server Response: ${json.encode(e.response!. data)}");
          } else {
            print("Server Response: ${e.response!.data}");
          }
        } catch (_) {
          print("Raw Response: ${e.response!.data}");
        }
      }
      print("========================\n");
      return null;
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return null;
    }
  }

  // ==================== MAIN API EXECUTION ====================
  Future<void> sendLatestChatToApi() async {
    if (!_validateBeforeAPI()) {
      return;
    }

    isLoading.value = true;
    outputText.value = '';

    // Extract messages (OPTIONAL - can be empty)
    final messages = _extractLatestMessages();
    String originalMessage = messages['originalMessage'] ?? '';
    String responseMessage = messages['responseMessage'] ?? '';

    print("\n🚀 SENDING TO API:");
    print("Original: ${originalMessage.  isEmpty ? '(empty)' : originalMessage}");
    print("Response: ${responseMessage.  isEmpty ? '(empty)' : responseMessage}");
    print("Mood: ${selectedMood. value}\n");

    var response = await _sendToApi(
      originalMessage: originalMessage,
      responseMessage: responseMessage,
      filePath: selectedFilePath. value.  isNotEmpty ? selectedFilePath.  value : null,
    );

    if (response != null) {
      if (response['result'] != null) {
        outputText.value = response['result'];
        _showSuccess('Response generated successfully');
      } else if (response['reply'] != null) {
        outputText.value = response['reply'];
        _showSuccess('Response generated successfully');
      } else {
        outputText.value = 'Invalid response format';
        _showError('Response format invalid');
      }
    } else {
      outputText.value = 'Failed to get response';
      _showError('Failed to connect to server');
    }

    isLoading.value = false;
  }
}