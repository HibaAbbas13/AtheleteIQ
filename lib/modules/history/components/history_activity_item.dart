import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class HistoryActivityItem extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final int? score;
  final int tokens;
  final IconData icon;
  final Color color;

  const HistoryActivityItem({
    super.key,
    required this.date,
    required this.title,
    required this.description,
    this.score,
    required this.tokens,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SlideFromLeftWidget(
      begin: -0.1,
      child: CustomCard(
        type: CardType.outlined,
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 24.w),
            ),

            SizedBox(width: 16.w),

            // Content
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
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        date,
                        style: AppTypography.kRegular12.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      if (score != null) ...[
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Score: $score',
                            style: AppTypography.kSemiBold12.copyWith(
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Tokens earned
            Column(
              children: [
                Icon(Iconsax.coin, color: AppColors.accentYellow, size: 20.w),
                SizedBox(height: 4.h),
                Text(
                  '+$tokens',
                  style: AppTypography.kSemiBold14.copyWith(
                    color: AppColors.accentYellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

