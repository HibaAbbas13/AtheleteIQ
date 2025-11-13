import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/animations/animated_widgets.dart';
import '../../controllers/user_controller.dart';
import '../../repo/user_repository.dart';
import '../../data/enums/user_role.dart';
import 'add_parent_screen.dart';

class ManageParentsScreen extends StatelessWidget {
  const ManageParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final userRepo = UserRepository();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Manage Parents',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final currentUser = userController.currentUser.value;
          
          if (currentUser == null || currentUser.role != UserRole.athlete) {
            return const Center(
              child: Text('Only athletes can manage parents'),
            );
          }

          final parents = currentUser.parents;

          return Column(
            children: [
              // Add Parent Button
              Padding(
                padding: EdgeInsets.all(24.w),
                child: CustomButton(
                  text: 'Add Parent',
                  icon: Iconsax.user_add,
                  onPressed: () => Get.to(() => const AddParentScreen()),
                ),
              ),

              // Parents List
              Expanded(
                child: parents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.people,
                              size: 64.w,
                              color: AppColors.grey400,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No parents added yet',
                              style: AppTypography.kRegular16.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Add a parent to share your profile',
                              style: AppTypography.kRegular14.copyWith(
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: parents.length,
                        itemBuilder: (context, index) {
                          final parent = parents[index];
                          return SlideFromLeftWidget(
                            delay: Duration(milliseconds: 100 * index),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColors.grey200,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48.w,
                                    height: 48.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryOrange.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Iconsax.user,
                                      color: AppColors.primaryOrange,
                                      size: 24.w,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          parent.name ?? 'Parent',
                                          style: AppTypography.kSemiBold16.copyWith(
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          parent.email,
                                          style: AppTypography.kRegular14.copyWith(
                                            color: AppColors.grey600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Iconsax.trash,
                                      color: AppColors.error,
                                      size: 20.w,
                                    ),
                                    onPressed: () async {
                                      final confirm = await Get.dialog<bool>(
                                        AlertDialog(
                                          title: const Text('Remove Parent'),
                                          content: Text(
                                            'Are you sure you want to remove ${parent.name ?? parent.email}? They will no longer be able to access your profile.',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Get.back(result: false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () => Get.back(result: true),
                                              style: TextButton.styleFrom(
                                                foregroundColor: AppColors.error,
                                              ),
                                              child: const Text('Remove'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        try {
                                          // Also unlink parent if they have linkedAthleteId
                                          final parentUser = await userRepo.getUserByEmail(parent.email);
                                          if (parentUser != null && parentUser.linkedAthleteId == currentUser.id) {
                                            await userRepo.unlinkParentFromAthlete(parentUser.id);
                                          }

                                          await userRepo.removeParentFromUser(
                                            currentUser.id,
                                            parent.email,
                                          );

                                          // Reload user data
                                          final updatedUser = await userRepo.getUserById(currentUser.id);
                                          if (updatedUser != null) {
                                            userController.updateUser(updatedUser);
                                          }

                                          Get.snackbar(
                                            'Parent Removed',
                                            '${parent.name ?? parent.email} has been removed from your account',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: AppColors.primaryGreen,
                                            colorText: Colors.white,
                                            duration: const Duration(seconds: 3),
                                            icon: const Icon(Iconsax.tick_circle, color: Colors.white),
                                            margin: EdgeInsets.all(16.w),
                                            borderRadius: 12.r,
                                          );
                                        } catch (e) {
                                          String errorMessage = 'Failed to remove parent. Please try again.';
                                          if (e.toString().contains('network') || e.toString().contains('NETWORK')) {
                                            errorMessage = 'Network error. Please check your connection.';
                                          }
                                          
                                          Get.snackbar(
                                            'Removal Failed',
                                            errorMessage,
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: AppColors.error,
                                            colorText: Colors.white,
                                            duration: const Duration(seconds: 3),
                                            icon: const Icon(Iconsax.close_circle, color: Colors.white),
                                            margin: EdgeInsets.all(16.w),
                                            borderRadius: 12.r,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

