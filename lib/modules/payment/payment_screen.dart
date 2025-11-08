import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/animations/animated_widgets.dart';
import 'components/billing_toggle.dart';
import 'components/plan_card.dart';
import 'components/features_section.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPlan = 'monthly';
  int _selectedTier = 1;

  final List<Map<String, dynamic>> _plans = [
    {
      'name': 'Basic',
      'price': '\$9.99',
      'period': '/month',
      'features': [
        '5 film evaluations/month',
        'Basic AI feedback',
        'Leaderboard access',
        'Email support',
      ],
      'gradient': [AppColors.grey600, AppColors.grey700],
      'popular': false,
    },
    {
      'name': 'Pro',
      'price': '\$19.99',
      'period': '/month',
      'features': [
        'Unlimited film evaluations',
        'Advanced AI feedback',
        'Priority leaderboard',
        'Personalized drills',
        '24/7 support',
      ],
      'gradient': [AppColors.primaryNeonOrange, AppColors.accentPink],
      'popular': true,
    },
    {
      'name': 'Elite',
      'price': '\$39.99',
      'period': '/month',
      'features': [
        'Everything in Pro',
        '1-on-1 coaching sessions',
        'Recruiter connections',
        'Advanced analytics',
        'Priority support',
      ],
      'gradient': [AppColors.primaryNeonCyan, AppColors.primaryNeonOrange],
      'popular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Choose Your Plan',
          style: AppTypography.kMontserratBold24.copyWith(
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [AppColors.primaryNeonOrange, AppColors.accentPink],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BillingToggle(
              selectedPlan: _selectedPlan,
              onPlanChanged: (plan) => setState(() => _selectedPlan = plan),
            ),

            SizedBox(height: 32.h),

            ...List.generate(_plans.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: PlanCard(
                  plan: _plans[index],
                  isSelected: _selectedTier == index,
                  index: index,
                  onTap: () => setState(() => _selectedTier = index),
                ),
              );
            }),

            SizedBox(height: 24.h),

            const FeaturesSection(),

            SizedBox(height: 32.h),

            FadeSlideWidget(
              delay: const Duration(milliseconds: 400),
              child: GradientButton(
                text: 'Subscribe with Stripe',
                gradientColors: AppColors.primaryGradient,
                icon: Iconsax.card,
                onPressed: _handleSubscribe,
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.lock, size: 16.w, color: AppColors.grey500),
                SizedBox(width: 8.w),
                Text(
                  'Secure payment powered by Stripe',
                  style: AppTypography.kRegular12.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  void _handleSubscribe() {
    Get.snackbar(
      'Subscription',
      'Redirecting to Stripe checkout...',
      backgroundColor: AppColors.cardDark,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
