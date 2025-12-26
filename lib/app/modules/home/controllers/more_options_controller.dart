import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptionsController extends GetxController {
  // Observable for friends invited count
  final friendsInvited = 0.obs;

  // Referral code
  final String referralCode = "OHQUGTL";

  // App version
  final String appVersion = "v 1.0.0";

  // URLs
  final String discordUrl = "https://discord.gg/YOUR_DISCORD_LINK";
  final String playStoreUrl = "https://play.google.com/store/apps/details?id=YOUR_APP_ID";
  final String termsUrl = "https://drive.google.com/file/d/1YcigMquNIGTC7Zf-0WosR0srTfc7gsnc/view";
  final String privacyUrl = "https://drive.google.com/file/d/1uVD-wdWeaCjzU-GCaGOYXdnszBnZAXcJ/view?usp=drivesdk";
  final String supportEmail = "support@wizardapp.xyz";

  // Copy referral code to clipboard
  void copyReferralCode() {
    Clipboard.setData(ClipboardData(text: referralCode));
    Get.snackbar(
      "Copied",
      "Referral code copied",
      colorText: Get.theme.colorScheme.onSurface,
      backgroundColor: Get.theme.colorScheme.surface.withAlpha(220),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Share referral code
  void shareReferralCode() async {
    await SharePlus.instance.share(
      ShareParams(
        subject: 'Join using my referral code!',
        text: 'Use my code: $referralCode',
      ),
      // Optional: Add a subject for email/some apps
    );
  }

  // Open Discord to claim free trial
  Future<void> openDiscordToClaim() async {
    await _launchURL("https://discord.com");
  }

  // Join Discord community
  Future<void> joinDiscord() async {
    await _launchURL(discordUrl);
  }

  // Contact support via email
  Future<void> contactSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      queryParameters: {'subject': 'Support Request'},
    );

    try {
      if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        Get.snackbar("Error", "Could not launch email app");
      }
    } catch (e) {
      Get.snackbar("Error", "Could not launch email app: $e");
    }
  }

  // Rate the app
  Future<void> rateApp() async {
    await _launchURL(playStoreUrl);
  }

  // Open terms
  Future<void> openTerms() async {
    await _launchURL(termsUrl);
  }

  // Open privacy policy
  Future<void> openPrivacy() async {
    await _launchURL(privacyUrl);
  }

  // Helper method to launch URLs
  Future<void> _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        Get.snackbar("Error", "Cannot open link");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot open link: $e");
    }
  }
}