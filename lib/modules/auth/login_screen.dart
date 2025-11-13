import 'package:athleteiq/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/app_colors.dart';
import '../../services/shared_preference.dart';
import '../../services/auth_service.dart';
import 'signup_screen.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authController = Get.find<AuthController>();
  final authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
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
                FadeSlideWidget(
                  duration: const Duration(milliseconds: 600),
                  slideBegin: 0.3,
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                FadeSlideWidget(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 100),
                  slideBegin: 0.3,
                  child: Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.grey600,
                    ),
                  ),
                ),

                SizedBox(height: 48.h),

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
                ),

                SizedBox(height: 24.h),

                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: true,
                  prefixIcon: Iconsax.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                CustomButton(
                  text: 'Sign In',
                  isLoading: _isLoading,
                  onPressed: () => _handleSignIn(),
                ),

                SizedBox(height: 24.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppColors.grey300, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: AppColors.grey300, thickness: 1),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grey600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => const SignupScreen()),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
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

  Future<void> _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final result = await authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );

        if (result.success && result.user != null) {
          print('[LoginScreen] Login successful! User: ${result.user?.name}, IsParentLogin: ${result.isParentLogin}');
          if (result.isParentLogin) {
            await SharedPreferencesService.setUserRole('parent');
          } else {
            await SharedPreferencesService.setUserRole('athlete');
          }

          _passwordController.clear();
          
          // Navigate back to let AuthWrapper handle navigation
          print('[LoginScreen] Navigating back to AuthWrapper...');
          Get.back();
        } else {
          print('[LoginScreen] Login failed: ${result.error}');
          Get.snackbar(
            'Login Failed',
            result.error ?? 'An error occurred during login',
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
