import 'package:athleteiq/services/shared_preference.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class AuthController extends GetxController with WidgetsBindingObserver {
  final Rx<bool> seenOnBoardingProcess = false.obs;
  bool get seenOnBoarding => seenOnBoardingProcess.value;

  final Rx<bool> isLoggedIn = false.obs;
  String userRole = '';

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
    userRole = await SharedPreferencesService.getUserRole();
  }

  @override
  Future<void> onReady() async {
    SharedPreferencesService.hasSeenTheOnboarding().then((value) {
      seenOnBoardingProcess.value = value;
    });
    super.onReady();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
