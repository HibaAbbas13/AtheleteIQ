import 'package:athleteiq/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../widgets/components/ai_score_gauge.dart';
import 'welcome_section.dart';
import 'tokens_card.dart';
import 'quick_actions.dart';
import 'ai_insights.dart';
import 'recent_activity.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return RefreshIndicator(
      onRefresh: () async {
        dashboardController.refreshData();
      },
      backgroundColor: AppColors.white,
      color: AppColors.primaryBlue,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeSection(),

            SizedBox(height: 32.h),
            Obx(
                  () => Center(
                    child: AIScoreGauge(
                      score: dashboardController.aiScore.value,
                      size: 220,
                      animate: true,
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 800.ms, delay: 200.ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 800.ms,
                  curve: Curves.easeOut,
                ),

            SizedBox(height: 32.h),

            Obx(() => TokensCard(tokens: dashboardController.tokens.value)),

            SizedBox(height: 24.h),

            const QuickActions(),

            SizedBox(height: 24.h),

            const AIInsights(),

            SizedBox(height: 24.h),

            const RecentActivity(),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
