import 'package:athleteiq/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import 'components/dashboard_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.white,
        appBar: navigationController.currentIndex.value == 0
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: AppColors.black),
                title: Text(
                  'RecruitAI',
                  style: AppTypography.kMontserratBold24.copyWith(
                    color: AppColors.black,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.notification, color: AppColors.black),
                  ),
                ],
              )
            : null,
        body: navigationController.currentIndex.value == 0
            ? const DashboardContent()
            : navigationController.getCurrentScreen(),
        bottomNavigationBar: _buildBottomNavigationBar(navigationController),
      ),
    );
  }

  Widget _buildBottomNavigationBar(NavigationController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.grey300, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) => controller.changePage(index),
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.grey500,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.kMedium12,
        unselectedLabelStyle: AppTypography.kMedium12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.video_play),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.chart_1),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(icon: Icon(Iconsax.clock), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
