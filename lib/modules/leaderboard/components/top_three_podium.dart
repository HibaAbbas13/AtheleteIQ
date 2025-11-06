import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../data/static_data.dart';
import '../../../widgets/components/custom_card.dart';

class TopThreePodium extends StatelessWidget {
  const TopThreePodium({super.key});

  @override
  Widget build(BuildContext context) {
    final topThree = StaticData.sampleLeaderboard.take(3).toList();

    return CustomCard(
          type: CardType.outlined,
          child: Column(
            children: [
              Text(
                'Top Performers',
                style: AppTypography.kSemiBold22.copyWith(
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),

              // Podium layout
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 2nd place
                  if (topThree.length >= 2)
                    PodiumSpot(entry: topThree[1], position: 2, height: 80.h),

                  SizedBox(width: 16.w),

                  // 1st place
                  if (topThree.isNotEmpty)
                    PodiumSpot(entry: topThree[0], position: 1, height: 100.h),

                  SizedBox(width: 16.w),

                  // 3rd place
                  if (topThree.length >= 3)
                    PodiumSpot(entry: topThree[2], position: 3, height: 60.h),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

class PodiumSpot extends StatelessWidget {
  final dynamic entry;
  final int position;
  final double height;

  const PodiumSpot({
    super.key,
    required this.entry,
    required this.position,
    required this.height,
  });

  Color _getPositionColor() {
    switch (position) {
      case 1:
        return AppColors.accentYellow;
      case 2:
        return AppColors.grey600;
      case 3:
        return AppColors.primaryOrange;
      default:
        return AppColors.grey600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getPositionColor();

    return Column(
      children: [
        // Avatar
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              entry.name.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),

        SizedBox(height: 8.h),

        // Name
        SizedBox(
          width: 70.w,
          child: Text(
            entry.name.split(' ')[0], // First name only
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(height: 8.h),

        // Podium base
        Container(
          width: 70.w,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            border: Border.all(color: color, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                position.toString(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                entry.aiScore.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
