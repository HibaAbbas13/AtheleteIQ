import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../widgets/components/custom_button.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class ResultsStep extends StatelessWidget {
  final Map<String, dynamic> result;
  final VoidCallback? onReset;

  const ResultsStep({
    super.key,
    required this.result,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideFromTopWidget(
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.tick_circle,
                    color: AppColors.success,
                    size: 24.w,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analysis Complete!',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'Here are your AI-powered insights',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          ScaleFadeWidget(
            delay: const Duration(milliseconds: 200),
            child: Center(
              child: ScoreCard(
                score: result['score'] ?? 0,
                label: 'AI ReScore',
                scoreColor: AppColors.primaryBlue,
                icon: Iconsax.star,
                subtitle: 'Out of 100 points',
              ),
            ),
          ),

          SizedBox(height: 32.h),

          FadeSlideWidget(
            delay: const Duration(milliseconds: 300),
            child: CustomCard(
              type: CardType.elevated,
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Feedback',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    result['feedback'] ?? 'No feedback available',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.grey600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),

          FadeSlideWidget(
            delay: const Duration(milliseconds: 400),
            child: CustomCard(
              type: CardType.filled,
              backgroundColor: AppColors.accentYellow.withOpacity(0.1),
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Icon(
                    Iconsax.coin,
                    color: AppColors.accentYellow,
                    size: 24.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      '+${result['tokensEarned'] ?? 0} tokens earned!',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentYellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),
      
          if (result['drillSuggestion'] != null)
            FadeSlideWidget(
              delay: const Duration(milliseconds: 500),
              child: CustomCard(
                type: CardType.outlined,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.book,
                          color: AppColors.primaryGreen,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Recommended Drill',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      result['drillSuggestion'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.grey600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: 'View Drill Details',
                      type: ButtonType.outline,
                      size: ButtonSize.small,
                      onPressed: () {
                        // TODO: Navigate to drill details
                      },
                    ),
                  ],
                ),
              ),
            ),

          SizedBox(height: 32.h),

          // Action buttons
          FadeSlideWidget(
            delay: const Duration(milliseconds: 600),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Upload Another',
                    type: ButtonType.outline,
                    onPressed: onReset,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomButton(
                    text: 'View Dashboard',
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

