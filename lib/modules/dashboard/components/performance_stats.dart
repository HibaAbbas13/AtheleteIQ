import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../data/static_data.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class PerformanceStats extends StatelessWidget {
  const PerformanceStats({super.key});

  int get filmsEvaluated {
    return StaticData.sampleEvaluations.length;
  }

  int get rank {
    final leaderboard = StaticData.sampleLeaderboard;
    final users = StaticData.sampleUsers;
    if (users.isNotEmpty && leaderboard.isNotEmpty) {
      final user = users.first;
      final entry = leaderboard.firstWhere(
        (e) => e.userId == user.id,
        orElse: () => leaderboard.first,
      );
      return entry.rank;
    }
    return 24;
  }

  int get dayStreak {
            return 7;
  }

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 600),
      slideBegin: 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Stats',
            style: AppTypography.kSemiBold22.copyWith(
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Iconsax.video_play,
                  value: filmsEvaluated.toString(),
                  label: 'Films Evaluated',
                  iconColor: AppColors.primaryBlue,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _StatCard(
                  icon: Iconsax.chart_1,
                  value: '#$rank',
                  label: 'Rank',
                  iconColor: AppColors.accentPurple,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _StatCard(
                  icon: Iconsax.calendar,
                  value: dayStreak.toString(),
                  label: 'Day Streak',
                  iconColor: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CardType.outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.w,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: AppTypography.kBold20.copyWith(
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.kRegular12.copyWith(
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }
}

