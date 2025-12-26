import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/replay_with_confidence/controllers/replay_with_confidence_modules_controller.dart';

void rwcshowApiOutputBottomSheet(BuildContext context) {
  final controller = Get.find<ReplayWithConfidenceModulesController>();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Advice'.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins')),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          controller.clearChatList();
                          controller.clearContext();
                        },
                        child: Icon(Icons.close, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(22),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[800]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: controller.isLoading.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Processing your request...'.tr,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      : TypewriterText(
                          text: controller.outputText.value.isEmpty
                              ? 'Output will appear here...'.tr
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GestureDetector(
                      onTap: controller.outputText.value.isEmpty
                          ? null
                          : () {
                              Clipboard.setData(ClipboardData(
                                  text: controller.outputText.value));
                              Get.snackbar(
                                'Copied'.tr,
                                'Output copied to clipboard'.tr,
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

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 30),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration.inMilliseconds * widget.text.length),
      vsync: this,
    );
    _charCount = IntTween(begin: 0, end: widget.text.length)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.forward();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.dispose();
      _controller = AnimationController(
        duration: Duration(milliseconds: widget.duration.inMilliseconds * widget.text.length),
        vsync: this,
      );
      _charCount = IntTween(begin: 0, end: widget.text.length)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
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
      builder: (context, child) {
        String displayText = widget.text.substring(0, _charCount.value);
        return SelectableText(displayText, style: widget.style);
      },
    );
  }
}
