import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PaymentCardInfoField extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvcController;
  final ValueChanged<String>? onCardNumberChanged;
  final ValueChanged<String>? onExpiryChanged;
  final ValueChanged<String>? onCvcChanged;

  const PaymentCardInfoField({
    super.key,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvcController,
    this.onCardNumberChanged,
    this.onExpiryChanged,
    this.onCvcChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     Text(
          'Card information'.tr,
          style: TextStyle(
            color: Color(0xFF737373),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              // Card Number
              Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withAlpha(128),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: cardNumberController,
                  onChanged: onCardNumberChanged,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    _CardNumberFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: '1234 1234 1234 1234',
                    hintStyle: const TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/icons/visa.png', width: 28, height: 18),
                          const SizedBox(width: 3),
                          Image.asset('assets/icons/master.png', width: 28, height: 18),
                          const SizedBox(width: 3),
                          Image.asset('assets/icons/american.png', width: 28, height: 18),
                          const SizedBox(width: 3),
                          Image.asset('assets/icons/discover.png', width: 28, height: 18),
                        ],
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              // MM/YY and CVC
              Row(
                children: [
                  // MM/YY
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.white.withAlpha(128),
                          ),
                          bottom: BorderSide(
                            color: Colors.white.withAlpha(128),
                          ),
                          top: BorderSide(
                            color: Colors.white.withAlpha(128),
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: TextField(
                        controller: expiryController,
                        onChanged: onExpiryChanged,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          _ExpiryDateFormatter(),
                        ],
                        decoration: const InputDecoration(
                          hintText: 'MM / YY',
                          hintStyle: TextStyle(
                            color: Color(0xFF737373),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CVC
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withAlpha(128),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: TextField(
                        controller: cvcController,
                        onChanged: onCvcChanged,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration: InputDecoration(
                          hintText: 'CVC',
                          hintStyle: const TextStyle(
                            color: Color(0xFF737373),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/cvc.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Card Number Formatter
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// Expiry Date Formatter
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' / ', '');

    if (text.length >= 2) {
      final month = text.substring(0, 2);
      final year = text.length > 2 ? text.substring(2) : '';
      final formatted = year.isEmpty ? month : '$month / $year';

      return newValue.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    return newValue;
  }
}