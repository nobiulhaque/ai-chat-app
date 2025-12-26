
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_images.dart';
import '../controllers/splash_controller.dart';



class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<SplashController>();
      controller.checkAndNavigate();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        decoration: const BoxDecoration(color: AppColors.black),
        child:  Center(
          child: Image.asset(AppImages.appLogo,width: 152.w,height: 169.h, fit: BoxFit.contain,),
        ),
      ),
    );
  }
}