import 'package:athleteiq/controllers/film_evaluation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../widgets/components/custom_card.dart';
import 'components/upload_step.dart';
import 'components/evaluating_step.dart';
import 'components/results_step.dart';

class FilmEvaluationScreen extends StatelessWidget {
  const FilmEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilmEvaluationController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Film Evaluation',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      body: Obx(() => _buildBody(context, controller)),
    );
  }

  Widget _buildBody(BuildContext context, FilmEvaluationController controller) {
    switch (controller.currentStep.value) {
      case 0:
        return UploadStep(controller: controller);
      case 1:
        return const EvaluatingStep();
      case 2:
        return ResultsStep(controller: controller);
      default:
        return UploadStep(controller: controller);
    }
  }
}
