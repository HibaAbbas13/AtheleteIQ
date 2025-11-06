import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // Sporty Sans-Serif Fonts: Poppins (primary) and Montserrat (alternate)

  // Regular - Poppins
  static TextStyle kRegular10 = GoogleFonts.poppins(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kRegular12 = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kRegular14 = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kRegular16 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );

  // Medium - Poppins
  static TextStyle kMedium10 = GoogleFonts.poppins(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kMedium12 = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kMedium14 = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kMedium16 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kMedium18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  // Semi-Bold - Poppins
  static TextStyle kSemiBold12 = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kSemiBold16 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kSemiBold18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kSemiBold22 = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kSemiBold26 = GoogleFonts.poppins(
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  // Bold - Poppins
  static TextStyle kBold20 = GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kBold24 = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kBold28 = GoogleFonts.poppins(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kBold32 = GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  // Montserrat - Alternate for headings
  static TextStyle kMontserratBold24 = GoogleFonts.montserrat(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle kMontserratBold32 = GoogleFonts.montserrat(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );

  // Neon Accent Text Styles
  static TextStyle neonOrangeText(double fontSize) => GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryNeonOrange,
  );

  static TextStyle neonCyanText(double fontSize) => GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryNeonCyan,
  );
}
