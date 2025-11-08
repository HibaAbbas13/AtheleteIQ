import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/animations/animated_widgets.dart';

class PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPopular = plan['popular'] as bool;

    return FadeSlideWidget(
      delay: Duration(milliseconds: index * 100),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSelected
                  ? (plan['gradient'] as List<Color>)
                  : [AppColors.cardDark, AppColors.cardDarker],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected
                  ? (plan['gradient'] as List<Color>).first.withOpacity(0.6)
                  : AppColors.grey700,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: (plan['gradient'] as List<Color>).first
                          .withOpacity(0.4),
                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Popular badge
                  if (isPopular)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.goldTierGlow,
                            AppColors.primaryNeonOrange,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldTierGlow.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        'MOST POPULAR',
                        style: AppTypography.kMedium10.copyWith(
                          color: AppColors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                  if (isPopular) SizedBox(height: 12.h),

                  // Plan name
                  Text(
                    plan['name'] as String,
                    style: AppTypography.kBold24.copyWith(
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan['price'] as String,
                        style: AppTypography.kBold32.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          plan['period'] as String,
                          style: AppTypography.kRegular14.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Features
                  ...(plan['features'] as List<String>).map((feature) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryNeonCyan,
                                  AppColors.primaryNeonOrange,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.tick_circle,
                              size: 14.w,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: AppTypography.kRegular14.copyWith(
                                color: AppColors.grey300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  SizedBox(height: 20.h),

                  // Select indicator
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white.withOpacity(0.3)
                            : AppColors.grey700,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected) ...[
                          Icon(
                            Iconsax.tick_circle,
                            size: 20.w,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          isSelected ? 'Selected' : 'Select Plan',
                          style: AppTypography.kSemiBold16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
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
}

