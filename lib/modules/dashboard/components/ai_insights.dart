import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../data/static_data.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class AIInsights extends StatelessWidget {
  const AIInsights({super.key});

  List<Map<String, dynamic>> get aiInsights {

    final drills = StaticData.sampleDrills;
    return drills.take(2).map((drill) => {
      'title': drill.title,
      'description': drill.description,
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 800),
      slideBegin: 0.2,
      child: Column(
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: aiInsights.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final insight = aiInsights[index];
                return InsightCard(
                  title: insight['title'],
                  description: insight['description'],
                  index: index,
                );
              },
            ),
          ],
        ),
    );
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
    return FadeSlideWidget(
      duration: const Duration(milliseconds: 400),
      delay: Duration(milliseconds: index * 100),
      slideBegin: 0.2,
      axis: Axis.horizontal,
      child: CustomCard(
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
        ),
    );
  }
}
