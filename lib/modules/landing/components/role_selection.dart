import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';

class RoleSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const RoleSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeSlideWidget(
      delay: const Duration(milliseconds: 400),
      child: CustomCard(
        type: CardType.outlined,
        onTap: onTap,
        child: Row(
          children: [
            // Icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, color: color, size: 30.w),
            ),

            SizedBox(width: 20.w),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.grey600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(Iconsax.arrow_right_3, color: color, size: 24.w),
          ],
        ),
      ),
    );
  }
}
