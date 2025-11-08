import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryNeonOrange = Color(0xFFFF3C00);
  static const Color primaryNeonCyan = Color(0xFF00FFC6); // Primary neon cyan
  static const Color primaryBlue = Color(0xFF1E3A8A); // Legacy support
  static const Color primaryOrange = Color(0xFFFF6B35); // Legacy support
  static const Color primaryGreen = Color(0xFF10B981); // Success green

  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF3B82F6); // Bright blue

  // Accent Colors
  static const Color accentYellow = Color(0xFFF59E0B); // Achievement yellow
  static const Color accentPurple = Color(0xFF8B5CF6); // Premium purple
  static const Color accentPink = Color(
    0xFFFF006E,
  ); // Pink accent for gradients

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF4F4F5);
  static const Color grey200 = Color(0xFFE4E4E7);
  static const Color grey300 = Color(0xFFD4D4D8);
  static const Color grey400 = Color(0xFFA1A1AA);
  static const Color grey500 = Color(0xFF71717A);
  static const Color grey600 = Color(0xFF52525B);
  static const Color grey700 = Color(0xFF3F3F46);
  static const Color grey800 = Color(0xFF27272A);

  // Background Colors - Dark Theme
  static const Color backgroundLight = Color(0xFFFAFBFC);
  static const Color backgroundDark = Color(0xFF0D0D0D); // RecruitAI dark base

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1A1A);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1F1F1F); // Glassmorphism cards
  static const Color cardDarker = Color(0xFF181818);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF18181B);
  static const Color textSecondaryLight = Color(0xFF71717A);

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA1A1AA);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Leaderboard Tier Colors - Glowing Neon Variants
  static const Color bronzeTier = Color(0xFFCD7F32);
  static const Color bronzeTierGlow = Color(0xFFFF8C42); // Glowing bronze
  static const Color silverTier = Color(0xFFC0C0C0);
  static const Color silverTierGlow = Color(0xFFE8E8E8); // Glowing silver
  static const Color goldTier = Color(0xFFFFD700);
  static const Color goldTierGlow = Color(0xFFFFF700); // Glowing gold
  static const Color platinumTier = Color(0xFFE5E4E2);
  static const Color platinumTierGlow = Color(0xFF00FFC6); // Neon cyan glow

  // Gradient Colors for special effects - RecruitAI Style
  static List<Color> primaryGradient = [
    primaryNeonOrange,
    accentPink,
  ]; // Orange to Pink

  // Border Colors
  static const Color borderLight = Color(0xFFE4E4E7);
  static const Color borderDark = Color(0xFF3F3F46);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);

  // Get colors based on theme - RecruitAI defaults to dark
  static Color getTextPrimary(BuildContext context) {
    // RecruitAI uses dark theme by default
    return textPrimaryDark;
  }

  static Color getTextSecondary(BuildContext context) {
    return textSecondaryDark;
  }

  static Color getBackground(BuildContext context) {
    return backgroundDark;
  }

  static Color getSurface(BuildContext context) {
    return surfaceDark;
  }

  static Color getCardColor(BuildContext context) {
    return cardDark;
  }
}
