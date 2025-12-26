import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentsModulesController extends GetxController {
  // Text Editing Controllers
  final emailController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final cardholderNameController = TextEditingController();
  final zipController = TextEditingController();

  // Observable variables
  final selectedCountry = 'United States'.obs;
  final isLoading = false.obs;

  // Form validation
  final isEmailValid = false.obs;
  final isCardNumberValid = false.obs;
  final isExpiryValid = false.obs;
  final isCvcValid = false.obs;
  final isCardholderNameValid = false.obs;
  final isZipValid = false.obs;


  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  @override
  void onClose() {
    // Dispose controllers
    emailController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    cardholderNameController.dispose();
    zipController.dispose();
    super.onClose();
  }

  final count = 0.obs;



  void _setupListeners() {
    // Email validation
    emailController.addListener(() {
      isEmailValid.value = _validateEmail(emailController.text);
    });

    // Card number validation
    cardNumberController.addListener(() {
      final cardNumber = cardNumberController.text.replaceAll(' ', '');
      isCardNumberValid.value = cardNumber.length == 16;
    });

    // Expiry validation
    expiryController.addListener(() {
      isExpiryValid.value = _validateExpiry(expiryController.text);
    });

    // CVC validation
    cvcController.addListener(() {
      isCvcValid.value = cvcController.text.length == 3;
    });

    // Cardholder name validation
    cardholderNameController.addListener(() {
      isCardholderNameValid.value = cardholderNameController.text.trim().length >= 3;
    });

    // ZIP validation
    zipController.addListener(() {
      isZipValid.value = zipController.text.length >= 5;
    });
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validateExpiry(String expiry) {
    if (expiry.length < 7) return false; // MM / YY format

    final parts = expiry.split(' / ');
    if (parts.length != 2) return false;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;

    // Check if card is expired
    final now = DateTime.now();
    final currentYear = now.year % 100; // Get last 2 digits
    final currentMonth = now.month;

    if (year < currentYear) return false;
    if (year == currentYear && month < currentMonth) return false;

    return true;
  }

  bool get isFormValid {
    return isEmailValid.value &&
        isCardNumberValid.value &&
        isExpiryValid.value &&
        isCvcValid.value &&
        isCardholderNameValid.value &&
        isZipValid.value;
  }

  void onCountryChanged(String? value) {
    if (value != null) {
      selectedCountry.value = value;
    }
  }

  Future<void> processPayment() async {
    if (!isFormValid) {
      Get.snackbar(
        'Validation Error',
        'Please fill all fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual payment processing here
      // Example:
      // final paymentData = {
      //   'email': emailController.text,
      //   'cardNumber': cardNumberController.text.replaceAll(' ', ''),
      //   'expiry': expiryController.text,
      //   'cvc': cvcController.text,
      //   'cardholderName': cardholderNameController.text,
      //   'country': selectedCountry.value,
      //   'zip': zipController.text,
      // };
      //
      // final response = await paymentService.processPayment(paymentData);

      Get.snackbar(
        'Success',
        'Payment processed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Clear form after successful payment
      _clearForm();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Payment processing failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _clearForm() {
    emailController.clear();
    cardNumberController.clear();
    expiryController.clear();
    cvcController.clear();
    cardholderNameController.clear();
    zipController.clear();
    selectedCountry.value = 'United States';
  }

  // Getters for payment data (if needed elsewhere)
  Map<String, dynamic> get paymentData => {
    'email': emailController.text,
    'cardNumber': cardNumberController.text.replaceAll(' ', ''),
    'expiry': expiryController.text,
    'cvc': cvcController.text,
    'cardholderName': cardholderNameController.text,
    'country': selectedCountry.value,
    'zip': zipController.text,
  };
}