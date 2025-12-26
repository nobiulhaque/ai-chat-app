import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final double width;
  final double height;

  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.width,
    required this.height,

    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: width,
            height: height,
            child: TextField(

              keyboardType: keyboardType,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF333333)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF333333)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF555555)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
