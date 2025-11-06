import 'package:athleteiq/controllers/film_evaluation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';

import '../../widgets/components/custom_button.dart';
import '../../widgets/components/custom_input.dart';
import '../../widgets/components/custom_card.dart';

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
        return _buildUploadStep(context, controller);
      case 1:
        return _buildEvaluatingStep(context, controller);
      case 2:
        return _buildResultsStep(context, controller);
      default:
        return _buildUploadStep(context, controller);
    }
  }

  Widget _buildUploadStep(
    BuildContext context,
    FilmEvaluationController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
                'Upload Your Film',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
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
                'Get instant AI analysis of your performance',
                style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 100.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 48.h),

          // Upload options
          CustomCard(
                type: CardType.elevated,
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Icon(
                      Iconsax.video_play,
                      size: 64.w,
                      color: AppColors.primaryBlue,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Choose how to upload',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // URL input option
                    CustomButton(
                      text: 'Paste Video URL',
                      type: ButtonType.outline,
                      icon: Iconsax.link,
                      onPressed: () => _showUrlInputDialog(context, controller),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      'or',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grey600,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // File upload option
                    CustomButton(
                      text: 'Upload from Device',
                      icon: Iconsax.document_upload,
                      onPressed: () => _handleFileUpload(controller),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 32.h),

          // Tips section
          CustomCard(
                type: CardType.outlined,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.info_circle,
                          color: AppColors.primaryBlue,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Tips for Best Results',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.getTextPrimary(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildTipItem('Use high-quality video (HD or higher)'),
                    _buildTipItem('Ensure good lighting and clear audio'),
                    _buildTipItem('Film from multiple angles when possible'),
                    _buildTipItem('Include both practice and game footage'),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 300.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }

  Widget _buildEvaluatingStep(
    BuildContext context,
    FilmEvaluationController controller,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated analyzing icon
          Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.cpu,
                  size: 60.w,
                  color: AppColors.primaryBlue,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                duration: 1000.ms,
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
              )
              .then()
              .scale(
                duration: 1000.ms,
                begin: const Offset(1.1, 1.1),
                end: const Offset(1, 1),
              ),

          SizedBox(height: 32.h),

          Text(
            'Analyzing Your Performance',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          Text(
            'Our AI is evaluating your film and generating insights...',
            style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 48.h),

          // Progress indicator
          SizedBox(
            width: 200.w,
            child: LinearProgressIndicator(
              backgroundColor: AppColors.grey200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'This usually takes 2-3 minutes',
            style: TextStyle(fontSize: 14.sp, color: AppColors.grey600),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsStep(
    BuildContext context,
    FilmEvaluationController controller,
  ) {
    final result = Map<String, dynamic>.from(controller.evaluationResult);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success header
          Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.tick_circle,
                      color: AppColors.success,
                      size: 24.w,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analysis Complete!',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'Here are your AI-powered insights',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 32.h),

          // Score display
          Center(
                child: ScoreCard(
                  score: result['score'] ?? 0,
                  label: 'AI ReScore',
                  scoreColor: AppColors.primaryBlue,
                  icon: Iconsax.star,
                  subtitle: 'Out of 100 points',
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 32.h),

          // Feedback section
          CustomCard(
                type: CardType.elevated,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Feedback',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      result['feedback'] ?? 'No feedback available',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.grey600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 300.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 24.h),

          // Tokens earned
          CustomCard(
                type: CardType.filled,
                backgroundColor: AppColors.accentYellow.withOpacity(0.1),
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.coin,
                      color: AppColors.accentYellow,
                      size: 24.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        '+${result['tokensEarned'] ?? 0} tokens earned!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentYellow,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),

          SizedBox(height: 24.h),

          // Suggested drill
          if (result['drillSuggestion'] != null)
            CustomCard(
                  type: CardType.outlined,
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.book,
                            color: AppColors.primaryGreen,
                            size: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Recommended Drill',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        result['drillSuggestion'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.grey600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: 'View Drill Details',
                        type: ButtonType.outline,
                        size: ButtonSize.small,
                        onPressed: () {
                          // TODO: Navigate to drill details
                        },
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 500.ms)
                .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),

          SizedBox(height: 32.h),

          // Action buttons
          Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Upload Another',
                      type: ButtonType.outline,
                      onPressed: () => controller.resetEvaluation(),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomButton(
                      text: 'View Dashboard',
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms)
              .slideY(
                begin: 0.3,
                end: 0,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.tick_circle, color: AppColors.success, size: 16.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.getTextSecondary(Get.context!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUrlInputDialog(
    BuildContext context,
    FilmEvaluationController controller,
  ) {
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

  void _handleFileUpload(FilmEvaluationController controller) {
    // TODO: Implement file picker
    // For now, simulate upload
    controller.uploadFilm('file://simulated_upload.mp4');
  }
}
