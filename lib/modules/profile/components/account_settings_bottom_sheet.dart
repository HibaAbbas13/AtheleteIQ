import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_typography.dart';
import '../../../widgets/components/custom_button.dart';

class AccountSettingsBottomSheet extends StatelessWidget {
  const AccountSettingsBottomSheet({super.key});

  static void show(BuildContext context) {
    Get.bottomSheet(
      AccountSettingsBottomSheet(),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: AppTypography.kBold24.copyWith(color: AppColors.black),
          ),
          SizedBox(height: 24.h),
          ListTile(
            leading: Icon(Iconsax.user_edit, color: AppColors.primaryBlue),
            title: Text('Edit Profile', style: AppTypography.kSemiBold16),
            subtitle: Text('Update your personal information',
                style: AppTypography.kRegular12),
            trailing: Icon(Iconsax.arrow_right_3, color: AppColors.grey600),
            onTap: () {},
          ),
          Divider(color: AppColors.grey300),
          ListTile(
            leading: Icon(Iconsax.gallery, color: AppColors.primaryOrange),
            title: Text('Change Picture', style: AppTypography.kSemiBold16),
            subtitle: Text('Update your profile photo',
                style: AppTypography.kRegular12),
            trailing: Icon(Iconsax.arrow_right_3, color: AppColors.grey600),
            onTap: () {},
          ),
          Divider(color: AppColors.grey300),
          ListTile(
            leading: Icon(Iconsax.lock, color: AppColors.primaryGreen),
            title: Text('Change Password', style: AppTypography.kSemiBold16),
            subtitle: Text('Update your account password',
                style: AppTypography.kRegular12),
            trailing: Icon(Iconsax.arrow_right_3, color: AppColors.grey600),
            onTap: () {},
          ),
          SizedBox(height: 24.h),
          CustomButton(
            text: 'Close',
            type: ButtonType.outline,
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}

