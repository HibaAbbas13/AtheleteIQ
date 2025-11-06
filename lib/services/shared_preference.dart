import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static String onboardingKey = 'onboarding';
  static String userRoleKey = 'user_role';
  static String ratingPromptShownKey = 'rating_prompt_shown';
  static String ratingPromptCountKey = 'rating_prompt_count';
  static String lastRatingPromptDateKey = 'last_rating_prompt_date';
  static String momentVisibilityKey = 'moment_visibility';

  static Future<void> seenTheOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(onboardingKey, true);
  }

  static Future<bool> hasSeenTheOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  static Future<void> setUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userRoleKey, role);
  }

  static Future<String> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRoleKey) ?? '';
  }

  static Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
