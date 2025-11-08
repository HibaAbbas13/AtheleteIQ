import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/welcome_section.dart';
import 'components/ai_score_card.dart';
import 'components/tokens_card.dart';
import 'components/performance_stats.dart';
import 'components/quick_actions.dart';
import 'components/ai_insights.dart';
import 'components/recent_activity.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeSection(),

          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: const AIScoreCard(),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: const TokensCard(),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          PerformanceStats(),

          SizedBox(height: 32.h),

          const QuickActions(),

          SizedBox(height: 32.h),

          const AIInsights(),

          SizedBox(height: 32.h),

          const RecentActivity(),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

