import 'package:flutter/material.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Profile',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Profile Screen',
          style: AppTypography.kSemiBold22.copyWith(color: AppColors.black),
        ),
      ),
    );
  }
}
