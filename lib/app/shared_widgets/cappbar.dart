// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/controllers/home_controller.dart';

class Cappbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onFlagTap;
  final VoidCallback? onMenuTap;
  final double flagSize;
  final double menuIconSize;
  final Color menuIconColor;
  final EdgeInsets padding;
  final double spacing;

  const Cappbar({
    Key? key,
    this.onFlagTap,
    this.onMenuTap,
    this.flagSize = 22,
    this.menuIconSize = 24,
    this.menuIconColor = Colors.white,
    this.padding = const EdgeInsets.only(top: 12, right: 16),
    this.spacing = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ⭐ Live Updating Flag (Emoji)
          GestureDetector(
            onTap: onFlagTap,
            child: Obx(
                  () => Text(
                homeController.getLanguageFlag(),
                style: TextStyle(
                  fontSize: flagSize,
                ),
              ),
            ),
          ),

          SizedBox(width: spacing),

          // ⭐ Menu Button
          GestureDetector(
            onTap: onMenuTap,
            child: Icon(
              Icons.menu,
              color: menuIconColor,
              size: menuIconSize,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
