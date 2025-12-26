// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import '../controllers/home_controller.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final Function(String) onLanguageSelected;

  const LanguageSelectionDialog({Key? key, required this.onLanguageSelected})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return AlertDialog(
      backgroundColor: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 500.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: homeController.languages.entries.map((entry) {
              final code = entry.key;
              final languageData = entry.value;
          
              return Obx(
                () => _LanguageButton(
                  language: languageData['name']!,
                  flag: languageData['flag']!,
                  code: code,
                  isSelected: homeController.selectedLanguage.value == code,
                  onTap: () {
                    homeController.updateLanguage(code);
                    onLanguageSelected(code);
                    Navigator.pop(context);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(16),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String language;
  final String flag;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.language,
    required this.flag,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 8.r, bottom: 8.r, left: 24.r, right: 24.r),
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.white.withAlpha(13)
              : AppColors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              language,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
             SizedBox(width: 12.r),
            Text(flag, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
