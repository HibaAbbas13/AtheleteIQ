import 'package:athleteiq/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                SlideFromTopWidget(
                  child: Text(
                    'Create Account',
                    style: AppTypography.kMontserratBold32.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                SlideFromTopWidget(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Join RecruitAI and start your journey',
                    style: AppTypography.kRegular16.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 400),
                  child: CustomTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    prefixIcon: Iconsax.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 500),
                  child: CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Iconsax.message,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 600),
                  child: CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Create a password',
                    obscureText: true,
                    prefixIcon: Iconsax.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                        return 'Password must contain at least one lowercase letter';
                      }
                      if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 12.h),

                Text(
                  'Password must contain at least 6 characters with uppercase, lowercase, and number.',
                  style: AppTypography.kRegular12.copyWith(
                    color: AppColors.grey600,
                  ),
                ),

                SizedBox(height: 32.h),

                FadeSlideWidget(
                  delay: const Duration(milliseconds: 700),
                  child: CustomButton(
                    text: 'Create Account',
                    type: ButtonType.primary,
                    isLoading: false,
                    onPressed: _handleSignUp,
                  ),
                ),

                SizedBox(height: 24.h),

                Text(
                  'By creating an account, you agree to our Terms of Service and Privacy Policy.',
                  style: AppTypography.kRegular12.copyWith(
                    color: AppColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Sign In',
                        style: AppTypography.kSemiBold16.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      final authController = Get.find<AuthController>();
      authController.login();
      Get.back();
    }
  }
}
