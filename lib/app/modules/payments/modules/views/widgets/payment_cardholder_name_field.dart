import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PaymentCardholderNameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const PaymentCardholderNameField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Cardholder name'.tr,
          style: TextStyle(
            color: Color(0xFF737373),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withAlpha(128),
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            cursorColor: Colors.white,
            keyboardType: TextInputType.name,
            decoration:  InputDecoration(
              hintText: 'Full name on card'.tr,
              hintStyle: TextStyle(
                color: Color(0xFF737373),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}