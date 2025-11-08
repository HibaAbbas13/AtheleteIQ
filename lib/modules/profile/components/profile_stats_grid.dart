import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';
import 'profile_stat_card.dart';

class ProfileStatsGrid extends StatelessWidget {
  const ProfileStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      delay: const Duration(milliseconds: 300),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                ProfileStatCard(
                  icon: Iconsax.calendar,
                  value: '-',
                  label: 'Current streak',
                  color: AppColors.primaryBlue,
                ),
                SizedBox(height: 12.h),
                ProfileStatCard(
                  icon: Iconsax.activity,
                  value: '-',
                  label: 'Activities last 30 days',
                  color: AppColors.primaryOrange,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              children: [
                ProfileStatCard(
                  icon: Iconsax.award,
                  value: '-',
                  label: 'Total activities',
                  color: AppColors.primaryGreen,
                ),
                SizedBox(height: 12.h),
                ProfileStatCard(
                  icon: Iconsax.clock,
                  value: '0m',
                  label: 'Time spent last 30 days',
                  color: AppColors.accentPurple,
                  isLocked: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

