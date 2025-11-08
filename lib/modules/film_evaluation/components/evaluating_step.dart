import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/app_colors.dart';

class EvaluatingStep extends StatelessWidget {
  const EvaluatingStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
}

