import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../data/static_data.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class TokensCard extends StatelessWidget {
  const TokensCard({super.key});

  int get tokens {
    // Use first user's tokens from static data as default
    final users = StaticData.sampleUsers;
    if (users.isNotEmpty) {
      return users.first.tokens;
    }
    return 15; // Default tokens
  }

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 400),
      slideBegin: 0.2,
      child: CustomCard(
        type: CardType.elevated,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryNeonOrange.withOpacity(0.2),
                    AppColors.primaryNeonOrange.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Iconsax.coin,
                color: AppColors.primaryNeonOrange,
                size: 24.w,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              tokens.toString(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                height: 1.0,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Tokens',
              style: AppTypography.kRegular14.copyWith(
                color: AppColors.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
