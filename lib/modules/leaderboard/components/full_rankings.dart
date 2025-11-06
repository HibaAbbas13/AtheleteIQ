import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../data/static_data.dart';
import '../../../models/user_model.dart';
import '../../../widgets/components/leaderboard_card.dart';

class FullRankings extends StatelessWidget {
  const FullRankings({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboardData = StaticData.sampleLeaderboard;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Rankings',
          style: AppTypography.kSemiBold22.copyWith(color: AppColors.black),
        ),
        SizedBox(height: 16.h),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: leaderboardData.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final entry = leaderboardData[index];
            return LeaderboardCard(
                  rank: entry.rank,
                  name: entry.name,
                  score: entry.aiScore,
                  tier: _getTierString(entry.tier),
                  sport: entry.sport?.name,
                  tokens: entry.tokens,
                  isCurrentUser:
                      index == 11, // Simulate current user at rank 12
                )
                .animate()
                .fadeIn(
                  duration: 400.ms,
                  delay: Duration(milliseconds: index * 100),
                )
                .slideX(
                  begin: 0.2,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOut,
                );
          },
        ),
      ],
    );
  }

  String _getTierString(Tier tier) {
    switch (tier) {
      case Tier.bronze:
        return 'Bronze';
      case Tier.silver:
        return 'Silver';
      case Tier.gold:
        return 'Gold';
      case Tier.platinum:
        return 'Platinum';
    }
  }
}
