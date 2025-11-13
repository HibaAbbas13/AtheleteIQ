import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:athleteiq/services/shared_preference.dart';
import '../models/user_model.dart';

class AuthController extends GetxController with WidgetsBindingObserver {
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _firebaseUser.value;
  bool get isAuthenticated => _firebaseUser.value != null;

  final Rx<bool> seenOnBoardingProcess = false.obs;
  bool get seenOnBoarding => seenOnBoardingProcess.value;

  final Rx<bool> isParentLogin = false.obs;
  final Rx<UserModel?> actualAthleteUser = Rx<UserModel?>(null);
  
  bool get isLoggedInAsParent => isParentLogin.value;
  UserModel? get athleteUser => actualAthleteUser.value;

  void updateOnboardingStatus(bool hasSeen) {
    seenOnBoardingProcess.value = hasSeen;
    SharedPreferencesService.seenTheOnboarding();
  }

  void setParentLogin(UserModel athleteUser) {
    isParentLogin.value = true;
    actualAthleteUser.value = athleteUser;
  }

  void clearParentLogin() {
    isParentLogin.value = false;
    actualAthleteUser.value = null;
  }

  Future<void> logout() async {
    clearParentLogin();
    await _auth.signOut();
    reset();
  }

  void reset() {
    clearParentLogin();
  }

  @override
  Future<void> onInit() async {
    _firebaseUser.bindStream(_auth.authStateChanges());
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      final hasSeenOnboarding = await SharedPreferencesService.hasSeenTheOnboarding();
      seenOnBoardingProcess.value = hasSeenOnboarding;
    } catch (e) {
      seenOnBoardingProcess.value = false;
    }
  }
}
