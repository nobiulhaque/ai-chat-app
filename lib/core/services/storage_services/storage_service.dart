// lib/core/services/storage_service.dart


import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final _box = GetStorage();
  static const String _onboardingKey = 'onboarding_seen';

  Future<void> init() async => await GetStorage.init();

  bool get isOnboardingSeen => _box.read(_onboardingKey) ?? false;

  Future<void> markOnboardingSeen() async => await _box.write(_onboardingKey, true);
}