import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../services/controller_manager.dart';
import '../modules/bottom_nav_bar/bottom_nav_bar.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/landing/landing_screen.dart';
import '../modules/profile/no_profile_linked_screen.dart';
import '../data/enums/user_role.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(), permanent: true);
    }
    
    final authController = Get.find<AuthController>();
    final userController = Get.find<UserController>();
    
    return Obx(() {
      if (!authController.seenOnBoarding) {
        return const OnboardingScreen();
      }
      
      if (!authController.isAuthenticated) {
        return const LandingScreen();
      }
  
      final controllerManager = ControllerManager();
      controllerManager.registerControllers();
      
      final currentUser = userController.currentUser.value;
      
      if (currentUser == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      
      // If parent has no linked athlete, show no profile linked screen
      if (currentUser.role == UserRole.parent && 
          currentUser.linkedAthleteId == null) {
        return const NoProfileLinkedScreen();
      }
      
      return const BottomNavBar();
    });
  }
}
