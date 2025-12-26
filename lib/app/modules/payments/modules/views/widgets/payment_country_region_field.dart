import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PaymentCountryRegionField extends StatelessWidget {
  final String selectedCountry;
  final ValueChanged<String?> onCountryChanged;
  final TextEditingController zipController;
  final ValueChanged<String>? onZipChanged;

  const PaymentCountryRegionField({
    super.key,
    required this.selectedCountry,
    required this.onCountryChanged,
    required this.zipController,
    this.onZipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Country or region'.tr,
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
              // Country Dropdown
              Container(
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
                child: DropdownButtonFormField<String>(
                  initialValue: selectedCountry,
                  dropdownColor: const Color(0xFF1A1A1A),
                  style: const TextStyle(
                    color: Color(0xFF737373),
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF737373),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'United States',
                      child: Text('United States'),
                    ),
                  ],
                  onChanged: onCountryChanged,
                ),
              ),

              // ZIP
              Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.white.withAlpha(128),
                    ),
                    right: BorderSide(
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
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: zipController,
                  onChanged: onZipChanged,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    hintText: 'ZIP'.tr,
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
            ],
          ),
        ),
      ],
    );
  }
}