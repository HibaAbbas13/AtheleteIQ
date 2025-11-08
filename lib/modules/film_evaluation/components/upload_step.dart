import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';
import '../../../widgets/components/custom_button.dart';
import '../../../widgets/components/custom_card.dart';
import '../../../widgets/animations/animated_widgets.dart';
import 'url_input_dialog.dart';
import 'tip_item.dart';

class UploadStep extends StatelessWidget {
  final Function(String)? onUpload;
  
  const UploadStep({super.key, this.onUpload});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          SlideFromTopWidget(
            child: Text(
              'Upload Your Film',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          SlideFromTopWidget(
            delay: const Duration(milliseconds: 100),
            child: Text(
              'Get instant AI analysis of your performance',
              style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
            ),
          ),

          SizedBox(height: 48.h),

          FadeSlideWidget(
            delay: const Duration(milliseconds: 200),
            child: CustomCard(
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

                  CustomButton(
                    text: 'Paste Video URL',
                    type: ButtonType.outline,
                    icon: Iconsax.link,
                    onPressed: () => UrlInputDialog.show(context, onUpload),
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

                  CustomButton(
                    text: 'Upload from Device',
                    icon: Iconsax.document_upload,
                    onPressed: () => _handleFileUpload(context),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 32.h),

          FadeSlideWidget(
            delay: const Duration(milliseconds: 300),
            child: CustomCard(
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
                  TipItem(tip: 'Use high-quality video (HD or higher)'),
                  TipItem(tip: 'Ensure good lighting and clear audio'),
                  TipItem(tip: 'Film from multiple angles when possible'),
                  TipItem(tip: 'Include both practice and game footage'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleFileUpload(BuildContext context) {
    // TODO: Implement file picker
    // For now, simulate upload
    if (onUpload != null) {
      onUpload!('file://simulated_upload.mp4');
    }
  }
}

