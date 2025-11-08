import 'package:athleteiq/controllers/auth_controller.dart';
import 'package:athleteiq/modules/auth/login_screen.dart';
import 'package:athleteiq/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/app_colors.dart';
import '../../widgets/components/custom_card.dart';
import '../../widgets/animations/animated_widgets.dart';
import 'components/role_selection.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              children: [
                // Header
                Column(
                  children: [
                    // Logo
                    ScaleInWidget(
                      child: Container(
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
                      ),
                    ),

                    SizedBox(height: 24.h),
                    
                    SlideFromTopWidget(
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        'Welcome to AthleteIQ',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    SlideFromTopWidget(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        'Choose how you\'d like to get started',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.grey600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

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

                SizedBox(height: 16.h),
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
        ),
      ),
    );
  }
}
