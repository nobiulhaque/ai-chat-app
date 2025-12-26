import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/app_colors.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        width: 54.r,
        height: 54.h,
        padding: EdgeInsets.only(left:  6.r),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
        ),
        child: Icon(Icons.arrow_back_ios,),
      ),
    );
  }
}