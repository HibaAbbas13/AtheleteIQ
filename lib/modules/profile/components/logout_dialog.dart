import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_button.dart';
import '../../../services/auth_service.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static void show(BuildContext context) {
    Get.dialog(LogoutDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.logout, color: AppColors.error, size: 48.w),
            SizedBox(height: 16.h),
            Text(
              'Sign Out',
              style: AppTypography.kBold20.copyWith(color: AppColors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'Are you sure you want to sign out?',
              style: AppTypography.kRegular14.copyWith(
                color: AppColors.grey600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    type: ButtonType.outline,
                    onPressed: () => Get.back(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    text: 'Sign Out',
                    onPressed: () {
                      Get.back();
                      final authService = AuthService();
                      authService.signOut();
                    },
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

