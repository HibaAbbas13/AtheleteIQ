import 'package:flutter/material.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'History',
          style: AppTypography.kMontserratBold24.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'History Screen',
          style: AppTypography.kSemiBold22.copyWith(color: AppColors.black),
        ),
      ),
    );
  }
}
