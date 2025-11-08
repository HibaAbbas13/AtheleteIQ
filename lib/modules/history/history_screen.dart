import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import 'components/history_stat_card.dart';
import 'components/history_activity_item.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Activity History',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.filter, color: AppColors.black),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: HistoryStatCard(
                      icon: Iconsax.video_play,
                      value: '12',
                      label: 'Films Evaluated',
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: HistoryStatCard(
                      icon: Iconsax.coin,
                      value: '340',
                      label: 'Tokens Earned',
                      color: AppColors.accentYellow,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              Text(
                'Recent Activity',
                style: AppTypography.kSemiBold18.copyWith(
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 16.h),

              HistoryActivityItem(
                date: 'Today, 2:45 PM',
                title: 'Film Evaluation Completed',
                description: 'Basketball practice footage analyzed',
                score: 85,
                tokens: 50,
                icon: Iconsax.video_play,
                color: AppColors.primaryBlue,
              ),

              SizedBox(height: 12.h),

              HistoryActivityItem(
                date: 'Yesterday, 4:20 PM',
                title: 'Drill Completed',
                description: 'Defensive positioning drill',
                tokens: 20,
                icon: Iconsax.teacher,
                color: AppColors.primaryGreen,
              ),

              SizedBox(height: 12.h),

              HistoryActivityItem(
                date: 'Nov 4, 6:15 PM',
                title: 'Film Evaluation Completed',
                description: 'Game highlights - Q4 performance',
                score: 78,
                tokens: 50,
                icon: Iconsax.video_play,
                color: AppColors.primaryBlue,
              ),

              SizedBox(height: 12.h),

              HistoryActivityItem(
                date: 'Nov 3, 3:30 PM',
                title: 'Profile Updated',
                description: 'Added new measurements and stats',
                tokens: 10,
                icon: Iconsax.user_edit,
                color: AppColors.primaryOrange,
              ),

              SizedBox(height: 12.h),

              HistoryActivityItem(
                date: 'Nov 2, 5:45 PM',
                title: 'Film Evaluation Completed',
                description: 'Training session footage',
                score: 72,
                tokens: 50,
                icon: Iconsax.video_play,
                color: AppColors.primaryBlue,
              ),

              SizedBox(height: 12.h),

              HistoryActivityItem(
                date: 'Nov 1, 7:00 PM',
                title: 'Achievement Unlocked',
                description: 'Reached Silver tier on leaderboard',
                tokens: 100,
                icon: Iconsax.award,
                color: AppColors.silverTierGlow,
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

}
