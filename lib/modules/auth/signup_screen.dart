import 'package:athleteiq/controllers/auth_controller.dart';
import 'package:athleteiq/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';

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
  String _selectedRole = 'athlete';

  @override
  void initState() {
    super.initState();
    final authController = Get.find<AuthController>();
    _selectedRole = authController.userRole;
  }

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
                // Title
                Text(
                      'Create Account',
                      style: AppTypography.kMontserratBold32.copyWith(
                        color: AppColors.black,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 8.h),

                Text(
                      'Join RecruitAI and start your journey',
                      style: AppTypography.kRegular16.copyWith(
                        color: AppColors.grey600,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 100.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 32.h),

                // Role Selection
                Text(
                  'I am a...',
                  style: AppTypography.kSemiBold18.copyWith(
                    color: AppColors.black,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                SizedBox(height: 16.h),

                // Animated Role Cards
                Row(
                      children: [
                        Expanded(
                          child: _buildRoleCard(
                            role: 'athlete',
                            icon: Iconsax.user,
                            title: 'Athlete',
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildRoleCard(
                            role: 'parent',
                            icon: Iconsax.people,
                            title: 'Parent',
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 300.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 32.h),

                // Form Fields
                CustomTextField(
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
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 24.h),

                CustomTextField(
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
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 500.ms)
                    .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 24.h),

                CustomTextField(
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
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 600.ms)
                    .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 12.h),

                Text(
                  'Password must contain at least 6 characters with uppercase, lowercase, and number.',
                  style: AppTypography.kRegular12.copyWith(
                    color: AppColors.grey600,
                  ),
                ),

                SizedBox(height: 32.h),

                // Sign Up Button
                CustomButton(
                      text: 'Create Account',
                      type: ButtonType.primary,
                      isLoading: false,
                      onPressed: _handleSignUp,
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 700.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: 24.h),

                // Terms
                Text(
                  'By creating an account, you agree to our Terms of Service and Privacy Policy.',
                  style: AppTypography.kRegular12.copyWith(
                    color: AppColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                // Sign In Link
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

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String title,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
        final authController = Get.find<AuthController>();
        SharedPreferencesService.setUserRole(role);
        authController.userRole = role;
      },
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryBlue : AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.grey300,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 32.w,
                      color: isSelected ? AppColors.white : AppColors.grey600,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      title,
                      style: AppTypography.kSemiBold16.copyWith(
                        color: isSelected ? AppColors.white : AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              )
              .animate(target: isSelected ? 1 : 0)
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 300.ms,
                curve: Curves.easeInOut,
              ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement actual signup logic
      final authController = Get.find<AuthController>();
      authController.login(); // Mark as logged in after signup
      // Use Get.back() so AuthWrapper handles navigation to dashboard
      Get.back();
    }
  }
}
