import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../services/auth_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthWrapper();
  }

  void _navigateToAuthWrapper() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.offAll(
        () => const AuthWrapper(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 800),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/icon
                  Container(
                        width: 140.w,
                        height: 140.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryBlue,
                        ),
                        child: Icon(
                          Iconsax.flash_1,
                          size: 70.w,
                          color: AppColors.white,
                        ),
                      )
                      .animate()
                      .scale(duration: 800.ms, curve: Curves.elasticOut)
                      .fadeIn(duration: 600.ms),

                  SizedBox(height: 48.h),

                  // Title
                  Text(
                        'RecruitAI',
                        style: AppTypography.kMontserratBold32.copyWith(
                          color: AppColors.black,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 300.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: 800.ms,
                        curve: Curves.easeOut,
                      ),

                  SizedBox(height: 16.h),

                  // Subtitle
                  Text(
                        'Your journey starts here',
                        style: AppTypography.kMedium18.copyWith(
                          color: AppColors.grey600,
                          letterSpacing: 1.2,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 500.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: 800.ms,
                        curve: Curves.easeOut,
                      ),

                  SizedBox(height: 64.h),

                  // Loading indicator
                  Container(
                    width: 200.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: Stack(
                      children: [
                        Container(
                              width: 200.w * 0.7,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .shimmer(
                              duration: 1500.ms,
                              color: AppColors.grey300.withOpacity(0.3),
                            ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
                ],
              ),
            ),

            // Bottom tagline
            Positioned(
              bottom: 48.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Icon(Iconsax.cpu, color: AppColors.grey400, size: 24.w)
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 1000.ms)
                      .then()
                      .fadeOut(duration: 1000.ms),
                  SizedBox(height: 8.h),
                  Text(
                    'Powered by AI',
                    style: AppTypography.kRegular14.copyWith(
                      color: AppColors.grey500,
                      letterSpacing: 1,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
