import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/film_evaluation_controller.dart';
import '../../../data/app_colors.dart';
import '../../../widgets/components/custom_button.dart';
import '../../../widgets/components/custom_input.dart';

class UrlInputDialog extends StatelessWidget {
  final FilmEvaluationController controller;

  const UrlInputDialog({
    super.key,
    required this.controller,
  });

  static void show(BuildContext context, FilmEvaluationController controller) {
    final urlController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Video URL',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextPrimary(context),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: urlController,
                hint: 'https://...',
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  if (!GetUtils.isURL(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      type: ButtonType.outline,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Analyze',
                      onPressed: () {
                        if (urlController.text.isNotEmpty) {
                          Get.back();
                          controller.uploadFilm(urlController.text);
                        }
                      },
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

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

