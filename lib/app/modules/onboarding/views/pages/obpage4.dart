import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/core/constant/app_colors.dart';
import 'package:social_wizard_app/core/utils/utils.dart';

import '../../../../routes/app_pages.dart';

class Obpage4 extends StatefulWidget {
  const Obpage4({super.key});

  @override
  State<Obpage4> createState() => _Obpage4State();
}

class _Obpage4State extends State<Obpage4> with TickerProviderStateMixin {
  static final List<String> _wizzyMessages = [
    'That outfit is giving main character energy ☀️. She looks incredible!'.tr,
    'Her smile is unreal 💪. Compliment it without being cringe.'.tr,
    'She\'s making time for you ❤️. Keep the energy matching hers!'.tr,
  ];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _wizzyMessages.length,
          (index) => AnimationController(
        duration: Duration(milliseconds: 2000 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      );
    }).toList();

    // Start animations with staggered delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              _buildHeader(context),
              SizedBox(height: 25.h),
              _buildNotificationEmoji(context),
              SizedBox(height: 35.h),
              _buildWizzyMessages(context),
              SizedBox(height: 60.h),
              _buildButtons(context),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Keep your streak 🔥'.tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Wing-man\'s got you 🔔'.tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationEmoji(BuildContext context) {
    return Text(
      '🔔',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 72.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildWizzyMessages(BuildContext context) {
    return Column(
      children: List.generate(
        _wizzyMessages.length,
            (index) => Column(
          children: [
            AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    -300 * (1 - _animations[index].value),
                  ),
                  child: Opacity(
                    opacity: _animations[index].value,
                    child: child,
                  ),
                );
              },
              child: _WizzyCard(message: _wizzyMessages[index]),
            ),
            if (index < _wizzyMessages.length - 1) SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        Utils.primaryButton(
          context: context,
          child: Text(
            'Got it! 🔔'.tr,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          radius: 16.r,
          height: 48.h,
          backgroundColor: AppColors.secondaryColor,
          textColor: AppColors.black,
          onTap: () {
            Get.toNamed(Routes.HOME);
          },
        ),
        SizedBox(height: 10.h),
        // _buildSkipButton(context),
      ],
    );
  }

}

class _WizzyCard extends StatelessWidget {
  final String message;

  const _WizzyCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/minihat.png', height: 60.h),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wizzy'.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}