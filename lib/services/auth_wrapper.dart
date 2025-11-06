import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../services/controller_manager.dart';
import '../modules/dashboard/dashboard_screen.dart';
import '../modules/landing/landing_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final authController = Get.find<AuthController>();
      if (!authController.seenOnBoarding) {
        return const OnboardingScreen();
      }
      final controllerManager = ControllerManager();
      controllerManager.registerFeatureControllers();

      if (authController.isLoggedIn.value) {
        return const DashboardScreen();
      } else {
        return const LandingScreen();
      }
    });
  }
}
