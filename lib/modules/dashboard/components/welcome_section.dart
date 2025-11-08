import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      duration: const Duration(milliseconds: 600),
      slideBegin: 0.2,
      child: CustomCard(
          type: CardType.outlined,
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.user, color: AppColors.white, size: 24.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: AppTypography.kSemiBold18.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Ready to improve your game?',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
