import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../data/static_data.dart';
import '../../../utils/score_utils.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class AIScoreCard extends StatelessWidget {
  const AIScoreCard({super.key});

  int get score {
    final users = StaticData.sampleUsers;
    if (users.isNotEmpty) {
      //return users.first.parents.first.userModel.aiScore;
    }
      return 82;
  }

  @override
  Widget build(BuildContext context) {
    final scoreColor = ScoreUtils.getScoreColor(score);
    final scoreLabel = ScoreUtils.getScoreLabel(score);

    return FadeSlideWidget(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 200),
      slideBegin: 0.2,
      child: CustomCard(
        type: CardType.elevated,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                scoreColor.withOpacity(0.15),
                scoreColor.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: scoreColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Iconsax.chart_2,
                      color: scoreColor,
                      size: 24.w,
                    ),
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: AppColors.grey400,
                    size: 20.w,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                score.toString(),
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                  height: 1.0,
                  shadows: [
                    Shadow(
                      color: scoreColor.withOpacity(0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'AI ReScore',
                style: AppTypography.kRegular14.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: scoreColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: scoreColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  scoreLabel,
                  style: AppTypography.kMedium12.copyWith(
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

