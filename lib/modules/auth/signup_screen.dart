import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';
import '../../services/auth_service.dart';
import '../../services/auth_wrapper.dart';
import '../../services/shared_preference.dart';

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
  final authService = AuthService();
  bool _isLoading = false;

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
                    isLoading: _isLoading,
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

  Future<void> _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Only athletes can sign up - parents are created by athletes
        final selectedRole = await SharedPreferencesService.getUserRole();
        if (selectedRole.isEmpty || selectedRole.toLowerCase() != 'athlete') {
          Get.snackbar(
            'Signup Restricted',
            'Only athletes can create accounts. Parents must use credentials provided by their athlete.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
          setState(() {
            _isLoading = false;
          });
          Get.offAll(() => const AuthWrapper());
          return;
        }

        final result = await authService.signUpWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
          _nameController.text.trim(),
        );

        if (result.success && result.user != null) {
          // Role is already set in AuthService from LandingScreen selection
          // No need to override it here
          
          // Clear fields
          _nameController.clear();
          _emailController.clear();
          _passwordController.clear();

          // Show success message
          Get.snackbar(
            'Success',
            'Account created successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primaryGreen,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
          );

          // Navigate back to let AuthWrapper handle navigation
          print('[SignupScreen] Signup successful! Navigating back to AuthWrapper...');
          Get.back();
        } else {
          // Show error message
          Get.snackbar(
            'Sign Up Failed',
            result.error ?? 'An error occurred during sign up',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
