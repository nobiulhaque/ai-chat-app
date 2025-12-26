import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_wizard_app/app/modules/payments/modules/views/widgets/payment_email_field.dart';
import 'package:social_wizard_app/app/modules/payments/modules/views/widgets/payment_card_info_field.dart';
import 'package:social_wizard_app/app/modules/payments/modules/views/widgets/payment_cardholder_name_field.dart';
import 'package:social_wizard_app/app/modules/payments/modules/views/widgets/payment_country_region_field.dart';
import 'package:social_wizard_app/app/modules/payments/modules/views/widgets/payment_submit_button.dart';

import '../../../../../core/constant/app_colors.dart';
import '../controllers/payments_modules_controller.dart';

class PaymentsModulesView extends GetView<PaymentsModulesController> {
  const PaymentsModulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 64,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 381),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/appLogo.png',
                  width: 152,
                  height: 142,
                ),

                const SizedBox(height: 24),

                // Email Field
                PaymentEmailField(
                  controller: controller.emailController,
                ),

                const SizedBox(height: 24),

                // Card Information
                PaymentCardInfoField(
                  cardNumberController: controller.cardNumberController,
                  expiryController: controller.expiryController,
                  cvcController: controller.cvcController,
                ),

                const SizedBox(height: 24),

                // Cardholder Name
                PaymentCardholderNameField(
                  controller: controller.cardholderNameController,
                ),

                const SizedBox(height: 24),

                // Country or Region
                Obx(() => PaymentCountryRegionField(
                  selectedCountry: controller.selectedCountry.value,
                  onCountryChanged: controller.onCountryChanged,
                  zipController: controller.zipController,
                )),

                const SizedBox(height: 24),


                // Pay Button
                Obx(() => PaymentSubmitButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.processPayment,
                  text: controller.isLoading.value ? 'Processing...'.tr : 'Pay'.tr,
                )),

            ])
          ),
        ),
      ),
    );
  }
}