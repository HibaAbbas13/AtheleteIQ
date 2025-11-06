import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_colors.dart';

// Leaderboard Card
class LeaderboardCard extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String tier;
  final String? sport;
  final int tokens;
  final bool isCurrentUser;

  const LeaderboardCard({
    Key? key,
    required this.rank,
    required this.name,
    required this.score,
    required this.tier,
    this.sport,
    required this.tokens,
    this.isCurrentUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.primaryBlue.withOpacity(0.05)
            : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isCurrentUser ? AppColors.primaryBlue : AppColors.grey300,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: _getRankColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: _getRankColor(),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isCurrentUser
                        ? AppColors.primaryBlue
                        : AppColors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getTierColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        tier.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: _getTierColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tokens
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tokens.toString(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentYellow,
                ),
              ),
              Text(
                'tokens',
                style: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return AppColors.goldTier;
      case 2:
        return AppColors.silverTier;
      case 3:
        return AppColors.bronzeTier;
      default:
        return AppColors.grey600;
    }
  }

  Color _getTierColor() {
    switch (tier.toLowerCase()) {
      case 'platinum':
        return AppColors.platinumTier;
      case 'gold':
        return AppColors.goldTier;
      case 'silver':
        return AppColors.silverTier;
      case 'bronze':
        return AppColors.bronzeTier;
      default:
        return AppColors.grey500;
    }
  }
}
