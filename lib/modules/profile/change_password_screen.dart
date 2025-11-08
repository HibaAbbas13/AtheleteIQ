import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_newPasswordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'New passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return;
    }

    if (_currentPasswordController.text == _newPasswordController.text) {
      Get.snackbar(
        'Error',
        'New password must be different from current password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Success',
        'Password updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryGreen,
        colorText: AppColors.white,
      );

      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update password: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Change Password',
          style: AppTypography.kBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            FadeSlideWidget(
              duration: const Duration(milliseconds: 300),
              slideBegin: 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Iconsax.lock,
                          color: AppColors.primaryGreen,
                          size: 24.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Update Your Password',
                              style: AppTypography.kBold20.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Enter your current password and choose a new one',
                              style: AppTypography.kRegular14.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            FadeSlideWidget(
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 100),
              slideBegin: 0.2,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _currentPasswordController,
                      label: 'Current Password',
                      hint: 'Enter your current password',
                      prefixIcon: Iconsax.lock_1,
                      obscureText: _obscureCurrentPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: _obscureCurrentPassword
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                      onSuffixTap: () {
                        setState(() {
                          _obscureCurrentPassword = !_obscureCurrentPassword;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: _newPasswordController,
                      label: 'New Password',
                      hint: 'Enter your new password',
                      prefixIcon: Iconsax.lock_1,
                      obscureText: _obscureNewPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: _obscureNewPassword
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                      onSuffixTap: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm New Password',
                      hint: 'Confirm your new password',
                      prefixIcon: Iconsax.lock_1,
                      obscureText: _obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      suffixIcon: _obscureConfirmPassword
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                      onSuffixTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    SizedBox(height: 32.h),
                    CustomButton(
                      text: 'Update Password',
                      onPressed: _isLoading ? null : _updatePassword,
                      isLoading: _isLoading,
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: 'Cancel',
                      type: ButtonType.outline,
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            FadeSlideWidget(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              slideBegin: 0.2,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.info_circle,
                          color: AppColors.primaryBlue,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Password Tips',
                          style: AppTypography.kSemiBold14.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    _PasswordTip(text: 'Use at least 6 characters'),
                    _PasswordTip(text: 'Include a mix of letters and numbers'),
                    _PasswordTip(text: 'Avoid using personal information'),
                    _PasswordTip(text: 'Don\'t reuse passwords from other accounts'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _PasswordTip extends StatelessWidget {
  final String text;

  const _PasswordTip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: AppColors.primaryBlue,
            size: 16.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTypography.kRegular12.copyWith(
                color: AppColors.grey600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

