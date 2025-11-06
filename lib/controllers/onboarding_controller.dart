import 'package:get/get.dart';

import 'package:athleteiq/services/shared_preference.dart';

import 'auth_controller.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final pageCount = 2;

  void nextPage() {
    if (currentPage.value < pageCount - 1) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void skipOnboarding() {
    _markOnboardingComplete();
  }

  void completeOnboarding() {
    _markOnboardingComplete();
  }

  void _markOnboardingComplete() async {
    await SharedPreferencesService.seenTheOnboarding();
    final authController = Get.find<AuthController>();
    authController.seenOnBoardingProcess.value = true;
  }
}
