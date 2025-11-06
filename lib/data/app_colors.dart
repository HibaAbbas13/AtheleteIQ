import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryNeonOrange = Color(0xFFFF3C00);
  static const Color primaryNeonCyan = Color(0xFF00FFC6); // Primary neon cyan
  static const Color primaryBlue = Color(0xFF1E3A8A); // Legacy support
  static const Color primaryOrange = Color(0xFFFF6B35); // Legacy support
  static const Color primaryGreen = Color(0xFF10B981); // Success green

  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF3B82F6); // Bright blue
  static const Color secondaryOrange = Color(0xFFF97316); // Darker orange
  static const Color secondaryGreen = Color(0xFF059669); // Darker green

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
  static const Color grey900 = Color(0xFF18181B);

  // Background Colors - Dark Theme
  static const Color backgroundLight = Color(0xFFFAFBFC);
  static const Color backgroundDark = Color(0xFF0D0D0D); // RecruitAI dark base
  static const Color backgroundDarker = Color(0xFF050505);

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceDarker = Color(0xFF151515); // Glassmorphism base

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1F1F1F); // Glassmorphism cards
  static const Color cardDarker = Color(0xFF181818);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF18181B);
  static const Color textSecondaryLight = Color(0xFF71717A);
  static const Color textTertiaryLight = Color(0xFFA1A1AA);

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA1A1AA);
  static const Color textTertiaryDark = Color(0xFF71717A);

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
  static List<Color> secondaryGradient = [
    primaryNeonCyan,
    primaryNeonOrange,
  ]; // Cyan to Orange
  static List<Color> successGradient = [
    primaryGreen,
    primaryNeonCyan,
  ]; // Green to Cyan
  static List<Color> achievementGradient = [
    accentYellow,
    primaryNeonOrange,
  ]; // Yellow to Orange
  static List<Color> premiumGradient = [
    accentPurple,
    primaryNeonCyan,
  ]; // Purple to Cyan
  static List<Color> neonGradient = [
    primaryNeonOrange,
    accentPink,
    primaryNeonCyan,
  ]; // Full neon spectrum

  // Border Colors
  static const Color borderLight = Color(0xFFE4E4E7);
  static const Color borderDark = Color(0xFF3F3F46);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x4DFFFFFF);

  // Sports Theme Specific Colors
  static const Color footballOrange = Color(0xFFFF6B35);
  static const Color basketballOrange = Color(0xFFFF8C42);
  static const Color baseballGreen = Color(0xFF22C55E);
  static const Color soccerGreen = Color(0xFF16A34A);
  static const Color tennisBlue = Color(0xFF2563EB);
  static const Color trackBlue = Color(0xFF1D4ED8);

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

  // Glassmorphism helper
  static Color getGlassColor() {
    return cardDark.withOpacity(0.3);
  }
}
