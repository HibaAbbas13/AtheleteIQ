import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_button.dart';
import '../../../widgets/components/custom_card.dart';

class TokensCard extends StatelessWidget {
  final int tokens;

  const TokensCard({super.key, required this.tokens});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
          type: CardType.outlined,
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(Iconsax.coin, color: AppColors.white, size: 28.w),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tokens',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      tokens.toString(),
                      style: AppTypography.kBold28.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Earn More',
                type: ButtonType.outline,
                size: ButtonSize.small,
                onPressed: () {
                  // TODO: Navigate to earn tokens
                },
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}
