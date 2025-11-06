import 'package:get/get.dart';

import '../modules/splash/splash_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/landing/landing_screen.dart';
import '../modules/auth/login_screen.dart';
import '../modules/auth/signup_screen.dart';
import '../modules/dashboard/dashboard_screen.dart';
import '../modules/film_evaluation/film_evaluation_screen.dart';
import '../modules/leaderboard/leaderboard_screen.dart';
import '../modules/payment/payment_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String filmEvaluation = '/film-evaluation';
  static const String leaderboard = '/leaderboard';
  static const String payment = '/payment';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: landing,
      page: () => const LandingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: filmEvaluation,
      page: () => const FilmEvaluationScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: leaderboard,
      page: () => const LeaderboardScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: payment,
      page: () => const PaymentScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
