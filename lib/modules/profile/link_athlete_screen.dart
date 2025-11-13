import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';
import '../../controllers/parent_controller.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../data/enums/user_role.dart';
import '../../repo/user_repository.dart';
import '../../services/auth_wrapper.dart';

class LinkAthleteScreen extends StatefulWidget {
  const LinkAthleteScreen({super.key});

  @override
  State<LinkAthleteScreen> createState() => _LinkAthleteScreenState();
}

class _LinkAthleteScreenState extends State<LinkAthleteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _parentController = Get.find<ParentController>();
  final _userRepo = UserRepository();
  bool _isLoading = false;
  UserModel? _foundAthlete;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _searchAthlete() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _foundAthlete = null;
      });

      try {
        final athlete = await _userRepo.getUserByEmail(_emailController.text.trim());
        
        if (athlete == null) {
          Get.snackbar(
            'Not Found',
            'No athlete found with this email',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
        } else if (athlete.role != UserRole.athlete) {
          Get.snackbar(
            'Invalid',
            'This email belongs to a ${athlete.role.name}, not an athlete',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
        } else {
          setState(() {
            _foundAthlete = athlete;
          });
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to search athlete: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _linkAthlete() async {
    if (_foundAthlete == null) {
      Get.snackbar(
        'No Athlete Selected',
        'Please search and select an athlete first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final success = await _parentController.linkToAthlete(_foundAthlete!.email);

    if (success) {
      // Reload user data to update linkedAthleteId
      final userController = Get.find<UserController>();
      final currentUser = userController.currentUser.value;
      if (currentUser != null) {
        final userRepo = UserRepository();
        final updatedUser = await userRepo.getUserById(currentUser.id);
        if (updatedUser != null) {
          userController.updateUser(updatedUser);
          
          // Load athlete data and set parent login
          if (updatedUser.linkedAthleteId != null) {
            final athlete = await userRepo.getUserById(updatedUser.linkedAthleteId!);
            if (athlete != null) {
              final authController = Get.find<AuthController>();
              userController.updateUser(athlete);
              authController.setParentLogin(athlete);
            }
          }
        }
      }
      
      // Navigate to main app - AuthWrapper will handle showing dashboard
      Get.offAll(() => const AuthWrapper());
    } else {
      // Linking failed - stay on screen so parent can try again
      // Clear the found athlete so they can search again
      setState(() {
        _foundAthlete = null;
        _emailController.clear();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Prevent back button - parent must link to athlete
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Link to Athlete',
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
                    'Find Your Athlete',
                    style: AppTypography.kMontserratBold32.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SlideFromTopWidget(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Enter your athlete\'s email to link your account',
                    style: AppTypography.kRegular16.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                SlideFromLeftWidget(
                  delay: const Duration(milliseconds: 200),
                  child: CustomTextField(
                    controller: _emailController,
                    label: 'Athlete Email',
                    hint: 'Enter athlete\'s email address',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Iconsax.message,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter athlete\'s email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'Search Athlete',
                  isLoading: _isLoading,
                  onPressed: _searchAthlete,
                ),
                if (_foundAthlete != null) ...[
                  SizedBox(height: 32.h),
                  FadeInWidget(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.user,
                                color: AppColors.primaryBlue,
                                size: 24.w,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _foundAthlete!.name,
                                      style: AppTypography.kSemiBold16.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _foundAthlete!.email,
                                      style: AppTypography.kRegular14.copyWith(
                                        color: AppColors.grey600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Obx(
                            () => CustomButton(
                              text: 'Link to This Athlete',
                              isLoading: _parentController.isLoading.value || _isLoading,
                              onPressed: _linkAthlete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

