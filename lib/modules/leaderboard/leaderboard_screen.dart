import 'package:athleteiq/data/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import 'components/current_user_card.dart';
import 'components/top_three_podium.dart';
import 'components/full_rankings.dart';
import 'components/filters_dialog.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => FiltersDialog.show(context),
            icon: Icon(Iconsax.filter, color: AppColors.black),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
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
}
