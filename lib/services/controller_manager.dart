import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/onboarding_controller.dart';
import '../controllers/user_controller.dart';

class ControllerManager {
  static final ControllerManager _instance = ControllerManager._internal();

  factory ControllerManager() {
    return _instance;
  }

  ControllerManager._internal();

  void registerEssentialControllers() {
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(), permanent: true);
    }

    if (!Get.isRegistered<NavigationController>()) {
      Get.put(NavigationController(), permanent: true);
    }

    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController(), permanent: true);
    }

    if (!Get.isRegistered<UserController>()) {
      Get.put(UserController(), permanent: true);
    }
  }

  void registerControllers() {
    registerEssentialControllers();
  }

  void unregisterControllers() {
    if (Get.isRegistered<AuthController>()) {
      Get.delete<AuthController>(force: true);
    }

    if (Get.isRegistered<NavigationController>()) {
      Get.delete<NavigationController>(force: true);
    }

    if (Get.isRegistered<OnboardingController>()) {
      Get.delete<OnboardingController>(force: true);
    }

    if (Get.isRegistered<UserController>()) {
      Get.delete<UserController>(force: true);
    }
  }
}
