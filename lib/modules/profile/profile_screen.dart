import 'package:athleteiq/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_card.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/animations/animated_widgets.dart';
import 'components/profile_stats_grid.dart';
import 'components/profile_menu_card.dart';
import 'components/account_settings_bottom_sheet.dart';
import 'components/logout_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Profile',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: [   
                  ScaleInWidget(
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryBlue,
                            AppColors.primaryBlue.withOpacity(0.7),
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          userController.userName.value.isNotEmpty
                              ? userController.userName.value[0].toUpperCase()
                              : 'A',
                          style: AppTypography.kBold32.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  FadeInWidget(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      userController.userName.value.isNotEmpty
                          ? userController.userName.value
                          : 'Athlete Name',
                      style: AppTypography.kBold24.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  FadeInWidget(
                    delay: const Duration(milliseconds: 150),
                    child: Text(
                      userController.userEmail.value.isNotEmpty
                          ? userController.userEmail.value
                          : 'athlete@example.com',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            const ProfileStatsGrid(),

            SizedBox(height: 24.h),

            SlideFromLeftWidget(
              delay: const Duration(milliseconds: 400),
              begin: -0.1,
              child: ProfileMenuCard(
                icon: Iconsax.setting_2,
                title: 'Account settings',
                subtitle: 'Edit your profile, picture or password',
                color: AppColors.primaryOrange,
                onTap: () => AccountSettingsBottomSheet.show(context),
              ),
            ),

            SizedBox(height: 32.h),
            FadeInWidget(
              delay: const Duration(milliseconds: 600),
              child: CustomButton(
                text: 'Sign Out',
                type: ButtonType.outline,
                icon: Iconsax.logout,
                onPressed: () => LogoutDialog.show(context),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

}
