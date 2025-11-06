import 'package:athleteiq/controllers/leaderboard_controller.dart';
import 'package:athleteiq/data/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/static_data.dart';
import '../../widgets/components/custom_button.dart';
import 'components/current_user_card.dart';
import 'components/top_three_podium.dart';
import 'components/full_rankings.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaderboardController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconsax.arrow_left, color: AppColors.black),
        ),
        title: Text(
          'Leaderboard',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showFiltersDialog(context),
            icon: Icon(Iconsax.filter, color: AppColors.black),
          ),
        ],
      ),
      body: Obx(() => _buildBody(context, controller)),
    );
  }

  Widget _buildBody(BuildContext context, LeaderboardController controller) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async => controller.loadLeaderboard(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            // Current user rank highlight
            CurrentUserCard(
              rank: 12,
              name: 'John Doe',
              score: 78,
              tier: 'Silver',
            ),

            SizedBox(height: 24.h),

            // Top 3 podium
            const TopThreePodium(),

            SizedBox(height: 24.h),

            // Full leaderboard
            const FullRankings(),
          ],
        ),
      ),
    );
  }

  void _showFiltersDialog(BuildContext context) {
    final controller = Get.find<LeaderboardController>();
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Leaderboard',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 24.h),

              // Sport filter
              Text(
                'Sport',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButton<String>(
                  value: controller.selectedSport.value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(
                      value: 'all',
                      child: Text('All Sports'),
                    ),
                    ...StaticData.sportsPositions.keys.map((sport) {
                      return DropdownMenuItem(
                        value: sport,
                        child: Text(sport.capitalizeFirst!),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.filterBySport(value);
                    }
                  },
                ),
              ),

              SizedBox(height: 16.h),

              // Position filter
              Text(
                'Position',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButton<String>(
                  value: controller.selectedPosition.value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(
                      value: 'all',
                      child: Text('All Positions'),
                    ),
                    ..._getPositionsForSport(
                      controller.selectedSport.value,
                    ).map((position) {
                      return DropdownMenuItem(
                        value: position,
                        child: Text(position),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.filterByPosition(value);
                    }
                  },
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Reset',
                      type: ButtonType.outline,
                      onPressed: () {
                        controller.filterBySport('all');
                        controller.filterByPosition('all');
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Apply',
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getPositionsForSport(String sport) {
    if (sport == 'all') return [];
    return StaticData.sportsPositions[sport] ?? [];
  }
}
