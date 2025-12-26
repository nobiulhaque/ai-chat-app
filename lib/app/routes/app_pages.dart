import 'package:get/get_navigation/src/routes/get_route.dart';
import '../modules/auth_screen/bindings/auth_screen_binding.dart';
import '../modules/auth_screen/views/auth_screen_view.dart';
import '../modules/break_the_ice_smooth/bindings/break_the_ice_smooth_modules_binding.dart';
import '../modules/break_the_ice_smooth/views/chat_screen.dart';
import '../modules/handle_the_curveballs/bindings/handle_the_curveballs_bindings.dart';
import '../modules/handle_the_curveballs/views/handle_the_curveballs_views.dart';
import 'package:social_wizard_app/app/modules/onboarding/views/pages/obpage1.dart';
import 'package:social_wizard_app/app/modules/onboarding/views/pages/obpage2.dart';
import 'package:social_wizard_app/app/modules/onboarding/views/pages/obpage3.dart';
import 'package:social_wizard_app/app/modules/onboarding/views/pages/obpage4.dart';
import 'package:social_wizard_app/app/modules/onboarding/views/pages/trial_screen.dart';
import 'package:social_wizard_app/app/modules/forget_password/views/reset_password/reset_passowrd.dart';
import 'package:social_wizard_app/app/modules/forget_password/views/verify_email_or_phone/verify_email_or_phone.dart';
import 'package:social_wizard_app/app/modules/forget_password/views/verify_otp/verify_otp.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/payments/modules/bindings/payments_modules_binding.dart';
import '../modules/payments/modules/views/payments_modules_view.dart';
import '../modules/replay_with_confidence/bindings/replay_with_confidence_modules_binding.dart';
import '../modules/replay_with_confidence/views/replay_with_confidence_modules_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENTS_MODULES,
      page: () => const PaymentsModulesView(),
      binding: PaymentsModulesBinding(),
    ),
    GetPage(name: _Paths.OBPAGE1, page: () => const Obpage1()),
    GetPage(name: _Paths.OBPAGE2, page: () => const Obpage2()),
    GetPage(name: _Paths.OBPAGE3, page: () => const Obpage3()),
    GetPage(name: _Paths.OBPAGE4, page: () => const Obpage4()),
    GetPage(name: _Paths.TRIAL_SCREEN, page: () => const TrialScreen()),
    GetPage(
      name: _Paths.AUTH_SCREEN,
      page: () => const AuthScreenView(),
      binding: AuthScreenBinding(),
    ),

    GetPage(
      name: _Paths.HANDLE_THE_CURVEBALLS,
      page: () => HandleTheCurveballsViews(),
      binding: HandleTheCurveballsModulesBinding(),
    ),

    GetPage(
      name: _Paths.REPLAY_WITH_CONFIDENCE_MODULES,
      page: () => ReplayWithConfidenceModulesView(),
      binding: ReplayWithConfidenceModulesBinding(),
    ),

    GetPage(
      name: _Paths.VERIFY_EMAIL_OR_PHONE,
      page: () => VerifyEmailOrPhone(),
      binding: ForgetPasswordBinding(),
    ),

    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () =>  ResetPassowrd(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtp(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.BREAKTHE_ICE_SMOOTH_CHAT,
      page: () => BreakTheIceSmoothChatView(),
      binding: BreakTheIceSmoothModulesBinding(),
    ),
    GetPage(
      name: _Paths.BREAKTHE_ICE_SMOOTH_MODULES,
      page: () => BreakTheIceSmoothChatView(),
      binding: BreakTheIceSmoothModulesBinding(),
    ),
  ];
}
