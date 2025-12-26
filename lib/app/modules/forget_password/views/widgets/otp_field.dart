import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;

  const OtpField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: PinCodeTextField(
        controller: controller,
        length: 6,
        obscureText: false,
        cursorColor: AppColors.hintTextColor,
        animationType: AnimationType.fade,

        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.r),
          borderWidth: 1,
          fieldHeight: 40.h,
          fieldWidth: 40.w,
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          activeColor: Colors.green,
          inactiveColor: const Color(0xFFA1A1A1).withAlpha(100),
          selectedColor: Colors.green,
        ),

        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        appContext: context,

        onChanged: (value) {
          controller.text = value;
        },
      ),
    );
  }
}
