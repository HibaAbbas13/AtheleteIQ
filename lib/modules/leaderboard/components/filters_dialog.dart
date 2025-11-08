import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/leaderboard_controller.dart';
import '../../../data/app_colors.dart';
import '../../../data/static_data.dart';
import '../../../widgets/components/custom_button.dart';

class FiltersDialog extends StatelessWidget {
  const FiltersDialog({super.key});

  static void show(BuildContext context) {
    final controller = Get.find<LeaderboardController>();
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Leaderboard',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 24.h),

              // Sport filter
              Text(
                'Sport',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedSport.value,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: [
                      const DropdownMenuItem(
                        value: 'all',
                        child: Text('All Sports'),
                      ),
                      ...StaticData.sportsPositions.keys.map((sport) {
                        return DropdownMenuItem(
                          value: sport,
                          child: Text(sport.capitalizeFirst!),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.filterBySport(value);
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Position filter
              Text(
                'Position',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedPosition.value,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: [
                      const DropdownMenuItem(
                        value: 'all',
                        child: Text('All Positions'),
                      ),
                      ..._getPositionsForSport(
                        controller.selectedSport.value,
                      ).map((position) {
                        return DropdownMenuItem(
                          value: position,
                          child: Text(position),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.filterByPosition(value);
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Reset',
                      type: ButtonType.outline,
                      onPressed: () {
                        controller.filterBySport('all');
                        controller.filterByPosition('all');
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Apply',
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<String> _getPositionsForSport(String sport) {
    if (sport == 'all') return [];
    return StaticData.sportsPositions[sport] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

