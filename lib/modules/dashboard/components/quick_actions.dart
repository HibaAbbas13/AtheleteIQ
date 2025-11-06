import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_card.dart';
import '../../film_evaluation/film_evaluation_screen.dart';
import '../../leaderboard/leaderboard_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: AppTypography.kSemiBold22.copyWith(color: AppColors.black),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Iconsax.video_play,
                    title: 'Upload Film',
                    subtitle: 'Get AI Analysis',
                    onTap: () => Get.to(() => const FilmEvaluationScreen()),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ActionCard(
                    icon: Iconsax.chart_1,
                    title: 'Leaderboard',
                    subtitle: 'See Rankings',
                    onTap: () => Get.to(() => const LeaderboardScreen()),
                  ),
                ),
              ],
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 600.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,
          child: CustomCard(
            type: CardType.outlined,
            child: Column(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: AppColors.white, size: 24.w),
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: AppTypography.kSemiBold16.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTypography.kRegular12.copyWith(
                    color: AppColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
        .animate()
        .scale(duration: 200.ms, curve: Curves.easeOut)
        .fadeIn(duration: 300.ms);
  }
}
