import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../repo/user_repository.dart';
import '../../models/parent.dart';
import '../../models/user_model.dart';
import '../../data/enums/user_role.dart';

class AddParentScreen extends StatefulWidget {
  const AddParentScreen({super.key});

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userRepo = UserRepository();
  final _userController = Get.find<UserController>();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createParentAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final currentUser = _userController.currentUser.value;
        if (currentUser == null || currentUser.role != UserRole.athlete) {
          Get.snackbar(
            'Access Denied',
            'Only athletes can create parent accounts',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            icon: const Icon(Iconsax.warning_2, color: Colors.white),
          );
          setState(() { _isLoading = false; });
          return;
        }

        // Check if email already exists in Firebase Auth
        try {
          final signInMethods = await _auth.fetchSignInMethodsForEmail(_emailController.text.trim());
          if (signInMethods.isNotEmpty) {
            Get.snackbar(
              'Email Already Registered',
              'This email is already in use. Please use a different email address.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.error,
              colorText: Colors.white,
              duration: const Duration(seconds: 4),
              icon: const Icon(Iconsax.info_circle, color: Colors.white),
            );
            setState(() { _isLoading = false; });
            return;
          }
        } catch (e) {
          // Email doesn't exist, continue
        }

        // Store current athlete's auth state
        final currentAthleteUser = _auth.currentUser;
        final parentEmail = _emailController.text.trim();
        final parentName = _nameController.text.trim();
        
        // Create Firebase Auth account for parent
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: parentEmail,
          password: _passwordController.text,
        );

        if (userCredential.user == null) {
          Get.snackbar(
            'Creation Failed',
            'Unable to create parent account. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            icon: const Icon(Iconsax.close_circle, color: Colors.white),
          );
          setState(() { _isLoading = false; });
          return;
        }

        // Create parent user model
        final parentUserModel = UserModel(
          id: userCredential.user!.uid,
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          role: UserRole.parent,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          parents: [],
          linkedAthleteId: currentUser.id, // Link to current athlete
        );

        // Parent is now authenticated, so they can create their own Firestore document
        try {
          // Save parent to Firestore (parent is authenticated, so they can create their own doc)
          await _userRepo.createUser(parentUserModel);
        } catch (e) {
          // If Firestore creation fails, delete the Firebase Auth user to maintain consistency
          try {
            await userCredential.user!.delete();
          } catch (_) {
            // Ignore deletion errors
          }
          
          String errorMessage = 'Failed to save parent data.';
          if (e.toString().contains('permission') || e.toString().contains('PERMISSION_DENIED')) {
            errorMessage = 'Permission denied. Please check Firestore security rules.';
          } else if (e.toString().contains('network') || e.toString().contains('NETWORK')) {
            errorMessage = 'Network error. Please check your internet connection.';
          }
          
          Get.snackbar(
            'Save Failed',
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            icon: const Icon(Iconsax.warning_2, color: Colors.white),
          );
          setState(() { _isLoading = false; });
          return;
        }
        
        // Add parent to athlete's parents list
        try {
          final parentToAdd = Parent(
            email: parentEmail,
            password: _passwordController.text,
            name: parentName,
          );

          await _userRepo.addParentToUser(currentUser.id, parentToAdd);
        } catch (e) {
          // If adding to parents list fails, show warning but continue
          Get.snackbar(
            'Warning',
            'Parent account created but failed to add to list. Please refresh.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primaryOrange,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            icon: const Icon(Iconsax.info_circle, color: Colors.white),
          );
          print('Warning: Failed to add parent to athlete list: $e');
        }

        // Sign back in as the athlete using their stored password
        if (currentAthleteUser != null && currentUser.password != null && currentUser.password!.isNotEmpty) {
          try {
            await _auth.signInWithEmailAndPassword(
              email: currentAthleteUser.email!,
              password: currentUser.password!,
            );
          } catch (e) {
            // If sign in fails, log but continue
            print('Warning: Could not sign back in as athlete: $e');
          }
        }
        
        // Clear parent login state and reload athlete's data
        final authController = Get.find<AuthController>();
        authController.clearParentLogin();
        
        // Reload athlete's data to update the parents list in UserController
        try {
          final updatedAthlete = await _userRepo.getUserById(currentUser.id);
          if (updatedAthlete != null) {
            _userController.updateUser(updatedAthlete);
          }
        } catch (e) {
          print('Warning: Could not reload athlete data: $e');
        }

        // Show success message with parent details
        Get.snackbar(
          'Parent Added Successfully',
          'Account created for $parentName. Share login credentials:\nEmail: $parentEmail',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryGreen,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          icon: const Icon(Iconsax.tick_circle, color: Colors.white),
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
        );

        // Clear form
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();

        // Navigate back to Manage Parents screen after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      } catch (e) {
        String errorMessage = 'An unexpected error occurred. Please try again.';
        
        if (e.toString().contains('email-already-in-use')) {
          errorMessage = 'This email is already registered. Please use a different email.';
        } else if (e.toString().contains('weak-password')) {
          errorMessage = 'Password is too weak. Please use a stronger password.';
        } else if (e.toString().contains('invalid-email')) {
          errorMessage = 'Invalid email address. Please check and try again.';
        } else if (e.toString().contains('network')) {
          errorMessage = 'Network error. Please check your internet connection.';
        }
        
        Get.snackbar(
          'Creation Failed',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          icon: const Icon(Iconsax.close_circle, color: Colors.white),
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
          'Add Parent',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideFromTopWidget(
                  child: Text(
                    'Create Parent Account',
                    style: AppTypography.kMontserratBold32.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SlideFromTopWidget(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Create login credentials for a parent to access your profile',
                    style: AppTypography.kRegular16.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 200),
                  child: CustomTextField(
                    controller: _nameController,
                    label: 'Parent Name',
                    hint: 'Enter parent\'s full name',
                    prefixIcon: Iconsax.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parent\'s name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    controller: _emailController,
                    label: 'Parent Email',
                    hint: 'Enter parent\'s email address',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Iconsax.message,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parent\'s email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 400),
                  child: CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Create a password for parent',
                    obscureText: true,
                    prefixIcon: Iconsax.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32.h),
                CustomButton(
                  text: 'Create Parent Account',
                  isLoading: _isLoading,
                  onPressed: _createParentAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
