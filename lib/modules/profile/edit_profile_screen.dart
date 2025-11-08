import 'package:athleteiq/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/animations/animated_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final userController = Get.find<UserController>();
    _nameController.text = userController.userName.value;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Choose Image Source',
              style: AppTypography.kBold20.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: _ImageSourceOption(
                    icon: Iconsax.camera,
                    label: 'Camera',
                    onTap: () {
                      Get.back();
                      _pickImage(ImageSource.camera);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _ImageSourceOption(
                    icon: Iconsax.gallery,
                    label: 'Gallery',
                    onTap: () {
                      Get.back();
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ),
              ],
            ),
            if (_selectedImage != null) ...[
              SizedBox(height: 16.h),
              CustomButton(
                text: 'Remove Photo',
                type: ButtonType.outline,
                onPressed: () {
                  setState(() {
                    _selectedImage = null;
                  });
                  Get.back();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userController = Get.find<UserController>();
      
      // TODO: Upload image to storage if _selectedImage is not null
      // TODO: Update user profile via API
      
          await Future.delayed(const Duration(seconds: 1));

      if (_nameController.text.isNotEmpty) {
        userController.userName.value = _nameController.text;
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryGreen,
        colorText: AppColors.white,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
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
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Edit Profile',
          style: AppTypography.kBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Profile Picture Section
              FadeSlideWidget(
                duration: const Duration(milliseconds: 300),
                slideBegin: 0.2,
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.w,
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
                              image: _selectedImage != null
                                  ? DecorationImage(
                                      image: FileImage(_selectedImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _selectedImage == null
                                ? Center(
                                    child: Text(
                                      _nameController.text.isNotEmpty
                                          ? _nameController.text[0].toUpperCase()
                                          : userController.userName.value.isNotEmpty
                                              ? userController.userName.value[0]
                                                  .toUpperCase()
                                              : 'A',
                                      style: TextStyle(
                                        fontSize: 48.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _showImageSourceDialog,
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBlue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryBlue.withOpacity(0.3),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Iconsax.camera,
                                  color: AppColors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Tap the camera icon to change your profile picture',
                        style: AppTypography.kRegular14.copyWith(
                          color: AppColors.grey600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Name Field
              FadeSlideWidget(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 100),
                slideBegin: 0.2,
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

              // Email Field (Read-only)
              FadeSlideWidget(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                slideBegin: 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: AppTypography.kMedium14.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.grey200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.sms,
                            color: AppColors.grey500,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              userController.userEmail.value.isNotEmpty
                                  ? userController.userEmail.value
                                  : 'No email available',
                              style: AppTypography.kRegular16.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                          ),
                          Icon(
                            Iconsax.lock,
                            color: AppColors.grey400,
                            size: 16.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Email cannot be changed',
                      style: AppTypography.kRegular12.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Action Buttons
              FadeSlideWidget(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                slideBegin: 0.2,
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Save Changes',
                      onPressed: _isLoading ? null : _updateProfile,
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

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 32.w,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: AppTypography.kMedium14.copyWith(
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

