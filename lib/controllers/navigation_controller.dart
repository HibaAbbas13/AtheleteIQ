import 'package:athleteiq/modules/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/film_evaluation/film_evaluation_screen.dart';
import '../modules/leaderboard/leaderboard_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/history/history_screen.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  Widget getCurrentScreen() {
    switch (currentIndex.value) {
      case 0:
          return const DashboardScreen();
      case 1:
        return const FilmEvaluationScreen();
      case 2:
        return const LeaderboardScreen();
      case 3:
        return const HistoryScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const DashboardScreen();
    }
  }

  void reset() {
    currentIndex.value = 0;
  }
}
