import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/animations/animated_widgets.dart';

class BillingToggle extends StatefulWidget {
  final String selectedPlan;
  final Function(String) onPlanChanged;

  const BillingToggle({
    super.key,
    required this.selectedPlan,
    required this.onPlanChanged,
  });

  @override
  State<BillingToggle> createState() => _BillingToggleState();
}

class _BillingToggleState extends State<BillingToggle> {
  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.grey700, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onPlanChanged('monthly'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: widget.selectedPlan == 'monthly'
                        ? LinearGradient(colors: AppColors.primaryGradient)
                        : null,
                    color: widget.selectedPlan == 'monthly'
                        ? null
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: widget.selectedPlan == 'monthly'
                        ? [
                            BoxShadow(
                              color: AppColors.primaryNeonOrange.withOpacity(
                                0.3,
                              ),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    'Monthly',
                    style: AppTypography.kSemiBold16.copyWith(
                      color: widget.selectedPlan == 'monthly'
                          ? AppColors.white
                          : AppColors.grey400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onPlanChanged('yearly'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: widget.selectedPlan == 'yearly'
                        ? LinearGradient(colors: AppColors.primaryGradient)
                        : null,
                    color: widget.selectedPlan == 'yearly'
                        ? null
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: widget.selectedPlan == 'yearly'
                        ? [
                            BoxShadow(
                              color: AppColors.primaryNeonOrange.withOpacity(
                                0.3,
                              ),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Yearly',
                        style: AppTypography.kSemiBold16.copyWith(
                          color: widget.selectedPlan == 'yearly'
                              ? AppColors.white
                              : AppColors.grey400,
                        ),
                      ),
                      if (widget.selectedPlan == 'yearly') ...[
                        SizedBox(width: 4.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryNeonCyan.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: AppColors.primaryNeonCyan.withOpacity(
                                0.5,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Save 20%',
                            style: AppTypography.kMedium10.copyWith(
                              color: AppColors.primaryNeonCyan,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

