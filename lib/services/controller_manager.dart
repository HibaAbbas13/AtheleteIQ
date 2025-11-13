import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/onboarding_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/parent_controller.dart';

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

    if (!Get.isRegistered<ParentController>()) {
      Get.put(ParentController(), permanent: true);
    }
  }

  void registerControllers() {
    registerEssentialControllers();
  }

  void resetControllers() {
    if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().clearUser();
    }

    if (Get.isRegistered<ParentController>()) {
        Get.find<ParentController>().reset();
    }

    if (Get.isRegistered<NavigationController>()) {
        Get.find<NavigationController>().reset();
    }

    if (Get.isRegistered<AuthController>()) {
        Get.find<AuthController>().reset();
    }
  }

  void unregisterControllers() {
    resetControllers();
    if (Get.isRegistered<NavigationController>()) {
      Get.delete<NavigationController>(force: true);
    }

    if (Get.isRegistered<OnboardingController>()) {
      Get.delete<OnboardingController>(force: true);
    }

    if (Get.isRegistered<UserController>()) {
      Get.delete<UserController>(force: true);
    }

    if (Get.isRegistered<ParentController>()) {
      Get.delete<ParentController>(force: true);
    }
  }
}
