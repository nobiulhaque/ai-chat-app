import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/break_the_ice_smooth_modules_controller.dart';


class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Properly find the existing controller (do NOT use Get.put here!)
    final controller = Get.find<BreakTheIceSmoothModulesController>();

    return SizedBox(
      height: 50,
      child: Obx(() {
        // This Obx now directly depends only on selectedMood
        final selectedMood = controller.selectedMood.value;

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.moods.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final mood = controller.moods[index];
            final isSelected = mood == selectedMood;

            return GestureDetector(
              onTap: () => controller.changeMood(mood),
              child: AnimatedContainer(
                alignment: AlignmentGeometry.center,
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF444444),
                    width: 1,
                  ),
                ),
                child: Text(
                  mood,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[400],
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}