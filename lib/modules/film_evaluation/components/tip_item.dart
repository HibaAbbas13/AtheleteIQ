import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';

class TipItem extends StatelessWidget {
  final String tip;

  const TipItem({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.tick_circle, color: AppColors.success, size: 16.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.getTextSecondary(Get.context!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

