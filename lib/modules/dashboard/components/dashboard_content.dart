import 'package:athleteiq/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
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

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          const WelcomeSection(),

          SizedBox(height: 24.h),

          // AI ReScore display
          Obx(
            () => Center(
              child: AIScoreGauge(
                score: dashboardController.currentScore.value,
                label: 'AI ReScore',
              ),
            ),
          ),

          SizedBox(height: 32.h),

          // Tokens card
          Obx(
            () => TokensCard(tokens: dashboardController.tokens.value),
          ),

          SizedBox(height: 32.h),

          // Quick Actions
          const QuickActions(),

          SizedBox(height: 32.h),

          // AI Insights
          const AIInsights(),

          SizedBox(height: 32.h),

          // Recent Activity
          const RecentActivity(),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

