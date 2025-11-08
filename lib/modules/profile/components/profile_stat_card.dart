import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_card.dart';

class ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool isLocked;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CardType.outlined,
      padding: EdgeInsets.all(16.w),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24.w),
              SizedBox(height: 12.h),
              Text(
                value,
                style: AppTypography.kBold24.copyWith(
                  color: isLocked ? AppColors.grey400 : color,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: AppTypography.kRegular12.copyWith(
                  color: AppColors.grey600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          if (isLocked)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.grey800,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(Iconsax.lock, color: AppColors.white, size: 12.w),
              ),
            ),
        ],
      ),
    );
  }
}

