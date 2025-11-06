import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/film_evaluation_controller.dart';
import '../controllers/leaderboard_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/onboarding_controller.dart';

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
  }

  void registerFeatureControllers() {
    if (!Get.isRegistered<DashboardController>()) {
      Get.put(DashboardController(), permanent: true);
    }

    if (!Get.isRegistered<FilmEvaluationController>()) {
      Get.put(FilmEvaluationController(), permanent: true);
    }

    if (!Get.isRegistered<LeaderboardController>()) {
      Get.put(LeaderboardController(), permanent: true);
    }
  }

  void registerControllers() {
    registerEssentialControllers();
    registerFeatureControllers();
  }

  void unregisterControllers() {
    if (Get.isRegistered<DashboardController>()) {
      Get.delete<DashboardController>(force: true);
    }

    if (Get.isRegistered<FilmEvaluationController>()) {
      Get.delete<FilmEvaluationController>(force: true);
    }

    if (Get.isRegistered<LeaderboardController>()) {
      Get.delete<LeaderboardController>(force: true);
    }

    if (Get.isRegistered<AuthController>()) {
      Get.delete<AuthController>(force: true);
    }

    if (Get.isRegistered<NavigationController>()) {
      Get.delete<NavigationController>(force: true);
    }

    if (Get.isRegistered<OnboardingController>()) {
      Get.delete<OnboardingController>(force: true);
    }
  }
}
