import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PaymentSubmitButton({
    super.key,
    this.onPressed,
    this.text = 'Pay',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        child: Text(
          text.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}