import 'package:athleteiq/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_card.dart';

class AIInsights extends StatelessWidget {
  const AIInsights({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AI Insights',
                  style: AppTypography.kSemiBold22.copyWith(
                    color: AppColors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to full insights
                  },
                  child: Text(
                    'View All',
                    style: AppTypography.kMedium14.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dashboardController.aiInsights.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final insight = dashboardController.aiInsights[index];
                  return InsightCard(
                    title: insight['title'],
                    description: insight['description'],
                    index: index,
                  );
                },
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 800.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final int index;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
          type: CardType.outlined,
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Iconsax.cpu, color: AppColors.white, size: 20.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.kSemiBold16.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Iconsax.arrow_right_3, color: AppColors.grey500, size: 20.w),
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: Duration(milliseconds: index * 100),
        )
        .slideX(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}
