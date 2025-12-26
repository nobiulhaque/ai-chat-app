// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/break_the_ice_smooth_modules_controller.dart';


// ---------------------------
// SHOW BOTTOM SHEET
// ---------------------------
void showBtiOutputSheet(BuildContext context, BreakTheIceSmoothModulesController controller) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Align(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Advice',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          controller.clearSavedContext();
                          },
                        child: Icon(Icons.close, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),

                // Output / Loading Container
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(22),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[800]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:controller.isLoading.value ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Processing your request...',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ) : BtiTypewriterText(
                      text: controller.outputText.value.isEmpty
                          ? 'Output will appear here...'
                          : controller.outputText.value,
                      style: TextStyle(
                        color: controller.outputText.value.isEmpty
                            ? Colors.grey[600]
                            : Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        height: 1.5,
                      ),
                    ),
                ),

                // COPY BUTTON
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GestureDetector(
                      onTap: controller.outputText.value.isEmpty
                          ? null
                          : () {
                              Clipboard.setData(
                                ClipboardData(text: controller.outputText.value),
                              );
                              Get.snackbar(
                                'Copied',
                                'Output copied to clipboard',
                                duration: const Duration(seconds: 2),
                              );
                            },
                      child: Icon(
                        Icons.copy,
                        color: controller.outputText.value.isEmpty
                            ? Colors.grey[700]
                            : Colors.orange,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// ---------------------------
// TYPEWRITER ANIMATION
// ---------------------------
class BtiTypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const BtiTypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 30),
  });

  @override
  State<BtiTypewriterText> createState() => _BtiTypewriterTextState();
}

class _BtiTypewriterTextState extends State<BtiTypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds * widget.text.length,
      ),
      vsync: this,
    );

    _charCount = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(BtiTypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text) {
      _controller.dispose();

      _controller = AnimationController(
        duration: Duration(
          milliseconds: widget.duration.inMilliseconds * widget.text.length,
        ),
        vsync: this,
      );

      _charCount = IntTween(
        begin: 0,
        end: widget.text.length,
      ).animate(_controller);

      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (_, __) {
        final text = widget.text.substring(0, _charCount.value);
        return SelectableText(text, style: widget.style);
      },
    );
  }
}
