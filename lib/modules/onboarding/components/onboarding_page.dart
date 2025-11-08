import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/animations/animated_widgets.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon
          ScaleInWidget(
            duration: const Duration(milliseconds: 800),
            child: icon,
          ),

          SizedBox(height: 48.h),

          // Title
          SlideFromTopWidget(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: Text(
              title,
              style: AppTypography.kMontserratBold32.copyWith(
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 16.h),

          // Description
          SlideFromTopWidget(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 400),
            child: Text(
              description,
              style: AppTypography.kRegular16.copyWith(
                color: AppColors.grey600,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

