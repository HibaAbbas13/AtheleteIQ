import 'package:athleteiq/controllers/auth_controller.dart';
import 'package:athleteiq/modules/auth/login_screen.dart';
import 'package:athleteiq/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/app_colors.dart';
import '../../widgets/components/custom_card.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Header
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.award,
                            color: AppColors.white,
                            size: 40.w,
                          ),
                        )
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.elasticOut)
                        .fadeIn(duration: 400.ms),

                    SizedBox(height: 24.h),
                    Text(
                          'Welcome to AthleteIQ',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .slideY(
                          begin: 0.3,
                          end: 0,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        ),

                    SizedBox(height: 12.h),

                    Text(
                          'Choose how you\'d like to get started',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.grey600,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 300.ms)
                        .slideY(
                          begin: 0.3,
                          end: 0,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Athlete card
                    RoleSelectionCard(
                      title: 'I\'m an Athlete',
                      subtitle:
                          'Upload films, get AI analysis, and track my recruiting progress',
                      icon: Iconsax.user,
                      color: AppColors.primaryBlue,
                      onTap: () async {
                        final authController = Get.find<AuthController>();
                        await SharedPreferencesService.setUserRole('athlete');
                        authController.userRole = 'athlete';
                        Get.to(() => const LoginScreen());
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Parent card
                    RoleSelectionCard(
                      title: 'I\'m a Parent',
                      subtitle:
                          'Support my athlete\'s recruiting journey and track their progress',
                      icon: Iconsax.people,
                      color: AppColors.primaryOrange,
                      onTap: () async {
                        final authController = Get.find<AuthController>();
                        await SharedPreferencesService.setUserRole('parent');
                        authController.userRole = 'parent';
                        Get.to(() => const LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const RoleSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
          type: CardType.outlined,
          onTap: onTap,
          child: Row(
            children: [
              // Icon
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(icon, color: color, size: 30.w),
              ),

              SizedBox(width: 20.w),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grey600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(Iconsax.arrow_right_3, color: color, size: 24.w),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}
