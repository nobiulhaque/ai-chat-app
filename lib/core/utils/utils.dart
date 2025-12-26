
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../constant/app_colors.dart';

class Utils {

  /// primary button
  static Widget primaryButton({
    required BuildContext context,
    VoidCallback? onTap,
    String? title,
    Widget? child,
    double? radius,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    double? width,
    double? height,
    double? fontSize,
    LinearGradient? gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? 56.h,
        // padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 20.r),
          border: Border.all(color: borderColor ?? Colors.grey),
          gradient: gradient,
        ),
        child:
        child ??
            Text(
              title ?? ' ',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 16.sp,
              ),
            ),
      ),
    );
  }


  /// custom Text Form Field with label
  static Widget customTextField({
    required BuildContext context,
    String? title,
    String? hintText,
    double? hintFontSize,
    TextEditingController? controller,
    Widget? suffixIcon,
    bool? obscureText,
    int? maxLine,
    Color? textColor,
    double? radius,
    ValueChanged<String>? onChanged,
    bool? readOnly,
    String? Function(String?)? validator
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor ?? AppColors.white,
          ),
        )
            : SizedBox.shrink(),
        SizedBox(height: 12.h),
        TextFormField(
          controller: controller,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.hintTextColor,
              fontWeight: FontWeight.w400,
              fontSize: hintFontSize ?? 18.sp,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white50),
              borderRadius: BorderRadius.circular(radius ?? 10.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white50),
              borderRadius: BorderRadius.circular(radius ?? 10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white50),
              borderRadius: BorderRadius.circular(radius ?? 10.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white50),
              borderRadius: BorderRadius.circular(radius ?? 10.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white50),
              borderRadius: BorderRadius.circular(radius ?? 10.r),
            ),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          maxLines: maxLine ?? 1,
        ),
      ],
    );
  }


  //
  // /// custom app bar with title
  // static Widget buildAppBarTitle({
  //   required BuildContext context,
  //   String? title,
  //   IconData? icon,
  //   Color? backgroundColor,
  //   Color? textColor,
  //   String? iconPath,
  //   Widget? child,
  //   double? elevation,
  //   String? subTitle,
  //   Color? iconColor,
  //   VoidCallback? onTap,
  // }) {
  //   return AppBar(
  //     leading: Utils.backButton(context: context, onTap: onTap),
  //     backgroundColor: backgroundColor ?? AppColors.primaryColor,
  //     surfaceTintColor: Colors.transparent,
  //     elevation: elevation ?? 4,
  //     toolbarHeight: 70.h,
  //     leadingWidth: 32.w,
  //     centerTitle: false,
  //     shadowColor: Color(0xFF000000).withAlpha(55),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         iconPath != null
  //             ? Image.asset(iconPath, width: 40.w)
  //             : Container(
  //           width: 40.w,
  //           height: 40.h,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //               colors: [
  //                 Color(0xFF2F7FA6).withAlpha(26),
  //                 Color(0xFF2F7FA6),
  //               ],
  //             ),
  //             shape: BoxShape.circle,
  //             border: Border.all(color: Color(0xFF1E546E), width: 2.w),
  //           ),
  //           child:
  //           child ??
  //               Icon(icon, color: iconColor ?? Colors.white, size: 24.r),
  //         ),
  //
  //         Spacer(),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(title ?? ''),
  //             subTitle != null
  //                 ? Text(
  //               subTitle,
  //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                 color: AppColors.secondaryColor,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             )
  //                 : SizedBox.shrink(),
  //           ],
  //         ),
  //         Spacer(),
  //         Spacer(),
  //         Spacer(),
  //       ],
  //     ),
  //     titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
  //       color: textColor ?? Color(0xFF2F7FA6),
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }

// ------------------------
// Contribution
// ------------------------
// FontEnd - {flutter dev} Bashar Al Habib, Md. Nobiul Haque Riyad, Mahabub Alam Tamim.
// Ai_Backend - {AI/ML dev} Mehedi Hasan Shishir.
//




}