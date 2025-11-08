import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/animations/animated_widgets.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      delay: const Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.cardDark, AppColors.cardDarker],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.grey700, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Plans Include',
              style: AppTypography.kSemiBold18.copyWith(
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Iconsax.shield_tick,
                  size: 20.w,
                  color: AppColors.primaryNeonCyan,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Secure payment processing',
                    style: AppTypography.kRegular14.copyWith(
                      color: AppColors.grey300,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Iconsax.refresh,
                  size: 20.w,
                  color: AppColors.primaryNeonCyan,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Cancel anytime',
                    style: AppTypography.kRegular14.copyWith(
                      color: AppColors.grey300,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Iconsax.star,
                  size: 20.w,
                  color: AppColors.primaryNeonCyan,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    '7-day free trial',
                    style: AppTypography.kRegular14.copyWith(
                      color: AppColors.grey300,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

