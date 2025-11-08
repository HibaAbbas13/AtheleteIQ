import 'package:flutter/material.dart';

import '../data/app_colors.dart';

class ScoreUtils {
  static Color getScoreColor(int score) {
    if (score >= 90) {
      return AppColors.platinumTierGlow;
    } else if (score >= 80) {
      return AppColors.goldTierGlow;
    } else if (score >= 70) {
      return AppColors.silverTierGlow;
    } else if (score >= 60) {
      return AppColors.bronzeTierGlow;
    } else {
      return AppColors.primaryNeonOrange;
    }
  }

  static String getScoreLabel(int score) {
    if (score >= 90) {
      return 'Elite';
    } else if (score >= 80) {
      return 'Excellent';
    } else if (score >= 70) {
      return 'Good';
    } else if (score >= 60) {
      return 'Fair';
    } else {
      return 'Improving';
    }
  }
}
  
