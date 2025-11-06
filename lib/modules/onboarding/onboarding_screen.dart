import 'package:athleteiq/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child:
                    TextButton(
                          onPressed: () {
                            Get.find<OnboardingController>()
                                .completeOnboarding();
                            Get.back();
                          },
                          child: Text(
                            'Skip',
                            style: AppTypography.kMedium16.copyWith(
                              color: AppColors.grey600,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: 0.2, end: 0, duration: 600.ms),
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [_buildOnboardingPage1(), _buildOnboardingPage2()],
              ),
            ),

            // Page indicator and navigation
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                children: [
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      return Container(
                            width: _currentPage == index ? 24.w : 8.w,
                            height: 8.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? AppColors.primaryBlue
                                  : AppColors.grey300,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          )
                          .animate()
                          .scale(
                            duration: 300.ms,
                            begin: const Offset(1, 1),
                            end: const Offset(1.1, 1.1),
                          )
                          .then()
                          .scale(
                            duration: 300.ms,
                            begin: const Offset(1.1, 1.1),
                            end: const Offset(1, 1),
                          );
                    }),
                  ),

                  SizedBox(height: 32.h),

                  // Navigation buttons
                  Row(
                    children: [
                      // Back button
                      if (_currentPage > 0) ...[
                        Expanded(
                          child: CustomButton(
                            text: 'Back',
                            type: ButtonType.outline,
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],

                      // Next/Get Started button
                      Expanded(
                        flex: _currentPage > 0 ? 1 : 2,
                        child: CustomButton(
                          text: _currentPage == 1 ? 'Get Started' : 'Next',
                          type: ButtonType.primary,
                          onPressed: () {
                            if (_currentPage == 1) {
                              Get.find<OnboardingController>()
                                  .completeOnboarding();
                              Get.back();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon
          Container(
                width: 180.w,
                height: 180.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBlue.withOpacity(0.1),
                ),
                child: Center(
                  child: Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryBlue,
                    ),
                    child: Icon(
                      Iconsax.video_play,
                      size: 70.w,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
              .animate()
              .scale(duration: 800.ms, curve: Curves.elasticOut)
              .fadeIn(duration: 600.ms),

          SizedBox(height: 48.h),

          // Title
          Text(
                'Upload Your Highlights',
                style: AppTypography.kMontserratBold32.copyWith(
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: 200.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 16.h),

          // Description
          Text(
                'Upload game footage or paste a Hudl/YouTube link. Our AI analyzes your performance instantly.',
                style: AppTypography.kRegular16.copyWith(
                  color: AppColors.grey600,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: 400.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated score gauge preview
          Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBlue.withOpacity(0.1),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular progress
                    SizedBox(
                      width: 170.w,
                      height: 170.w,
                      child: CircularProgressIndicator(
                        value: 0.87,
                        strokeWidth: 8,
                        backgroundColor: AppColors.grey200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBlue,
                        ),
                      ),
                    ),
                    // Score text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '87',
                          style: AppTypography.kBold32.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'AI ReScore',
                          style: AppTypography.kRegular12.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .scale(duration: 800.ms, curve: Curves.elasticOut)
              .fadeIn(duration: 600.ms),

          SizedBox(height: 48.h),

          // Title
          Text(
                'AI-Powered Progress',
                style: AppTypography.kMontserratBold32.copyWith(
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: 200.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 16.h),

          // Description
          Text(
                'Receive detailed AI analysis with scores (1-100), personalized improvement tips, and track your progress on the leaderboard.',
                style: AppTypography.kRegular16.copyWith(
                  color: AppColors.grey600,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: 400.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }
}
