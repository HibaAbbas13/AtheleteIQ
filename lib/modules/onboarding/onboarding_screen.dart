import 'package:athleteiq/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/animations/animated_widgets.dart';
import 'components/onboarding_page.dart';

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
                child: SlideFromRightWidget(
                  child: TextButton(
                    onPressed: () {
                      Get.find<OnboardingController>().completeOnboarding();
                   
                    },
                    child: Text(
                      'Skip',
                      style: AppTypography.kMedium16.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ),
                ),
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
                children: [
                  OnboardingPage(
                    title: 'Upload Your Highlights',
                    description:
                        'Upload game footage or paste a Hudl/YouTube link. Our AI analyzes your performance instantly.',
                    icon: Container(
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
                    ),
                  ),
                  OnboardingPage(
                    title: 'AI-Powered Progress',
                    description:
                        'Receive detailed AI analysis with scores (1-100), personalized improvement tips, and track your progress on the leaderboard.',
                    icon: Container(
                      width: 200.w,
                      height: 200.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryBlue.withOpacity(0.1),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
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
                    ),
                  ),
                ],
              ),
            ),

            // Page indicator and navigation
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                children: [
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

                  Row(
                    children: [
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

                      Expanded(
                        flex: _currentPage > 0 ? 1 : 2,
                        child: CustomButton(
                          text: _currentPage == 1 ? 'Get Started' : 'Next',
                          type: ButtonType.primary,
                          onPressed: () {
                            if (_currentPage == 1) {
                              Get.find<OnboardingController>()
                                  .completeOnboarding();
                              // Navigation will be handled by AuthWrapper reactively
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

}
