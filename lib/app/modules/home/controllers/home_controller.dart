// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  // GetStorage instance
  late final GetStorage _storage;
  final String _languageKey = 'selectedLanguage';

  // Selected language & flag
  final selectedLanguage = 'en'. obs;
  final selectedLanguageFlag = '🇬🇧'.obs;

  // Language list with flags + locale codes
  final Map<String, Map<String, String>> languages = {
    'en': {'name': 'English', 'flag': '🇬🇧', 'country': 'US'},
    'fr': {'name': 'French', 'flag': '🇫🇷', 'country': 'FR'},
    'es': {'name': 'Spanish', 'flag': '🇪🇸', 'country': 'ES'},
    'de': {'name': 'German', 'flag': '🇩🇪', 'country': 'DE'},
    'it': {'name': 'Italian', 'flag': '🇮🇹', 'country': 'IT'},
    'sv': {'name': 'Swedish', 'flag': '🇸🇪', 'country': 'SE'},
    'pt': {'name': 'Portuguese', 'flag': '🇵🇹', 'country': 'PT'},
  };

  @override
  void onInit() {
    super.onInit();
    _storage = GetStorage(); // ✅ Initialize GetStorage instance
    _loadLanguagePreference();
  }

  // Load saved language from GetStorage
  void _loadLanguagePreference() {
    try {
      // Try to load saved language, default to 'en'
      String savedLanguage = _storage.read<String>(_languageKey) ?? 'en';

      // Validate that the saved language exists
      if (languages.containsKey(savedLanguage)) {
        selectedLanguage.value = savedLanguage;
        selectedLanguageFlag. value = languages[savedLanguage]!['flag']!;

        // Apply the locale
        final countryCode = languages[savedLanguage]!['country']!;
        Get.updateLocale(Locale(savedLanguage, countryCode));

        debugPrint("✅ Language loaded from storage → $savedLanguage-$countryCode");
      } else {
        // Fallback to English if saved language is invalid
        selectedLanguage.value = 'en';
        selectedLanguageFlag.value = languages['en']!['flag']! ;
        _storage.write(_languageKey, 'en');

        debugPrint("⚠️ Invalid saved language, reset to English");
      }
    } catch (e) {
      debugPrint("❌ Error loading language preference: $e");
      selectedLanguage.value = 'en';
      selectedLanguageFlag. value = languages['en']!['flag']!;
    }
  }

  // Update selected language and save to GetStorage
  void updateLanguage(String code) {
    if (languages.containsKey(code)) {
      selectedLanguage. value = code;
      selectedLanguageFlag.value = languages[code]!['flag']!;

      final countryCode = languages[code]!['country']!;
      Get.updateLocale(Locale(code, countryCode));

      // Save to GetStorage
      _storage.write(_languageKey, code);

      debugPrint("✅ Language updated → $code-$countryCode (saved to storage)");
    }
  }

  // Get current language name
  String getLanguageName() {
    return languages[selectedLanguage.value]!['name']!;
  }

  // Get language flag
  String getLanguageFlag() {
    return selectedLanguageFlag.value;
  }

  // Get language name by code
  String getLanguageNameByCode(String code) {
    return languages[code]? ['name'] ?? 'Unknown';
  }
}