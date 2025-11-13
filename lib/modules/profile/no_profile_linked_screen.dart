import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/animations/animated_widgets.dart';
import '../../controllers/auth_controller.dart';

class NoProfileLinkedScreen extends StatelessWidget {
  const NoProfileLinkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInWidget(
                child: Icon(
                  Iconsax.profile_delete,
                  size: 80.w,
                  color: AppColors.error,
                ),
              ),
              SizedBox(height: 24.h),
              SlideFromTopWidget(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'No Profile Linked',
                  style: AppTypography.kMontserratBold32.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.h),
              SlideFromTopWidget(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'Your account is not linked to any athlete profile. Please contact your athlete to link your account.',
                  style: AppTypography.kRegular16.copyWith(
                    color: AppColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48.h),
              CustomButton(
                text: 'Sign Out',
                type: ButtonType.outline,
                icon: Iconsax.logout,
                onPressed: () {
                  authController.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

