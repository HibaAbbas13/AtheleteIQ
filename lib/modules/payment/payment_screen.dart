import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';
import '../../widgets/components/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPlan = 'monthly';
  int _selectedTier = 1; // 0: Basic, 1: Pro, 2: Elite

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
            // Billing period toggle
            _buildBillingToggle(),

            SizedBox(height: 32.h),

            // Plans
            ...List.generate(_plans.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: _buildPlanCard(index),
              );
            }),

            SizedBox(height: 24.h),

            // Features comparison
            _buildFeaturesSection(),

            SizedBox(height: 32.h),

            // CTA Button
            GradientButton(
                  text: 'Subscribe with Stripe',
                  gradientColors: AppColors.primaryGradient,
                  icon: Iconsax.card,
                  onPressed: _handleSubscribe,
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),

            SizedBox(height: 16.h),

            // Security note
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

  Widget _buildBillingToggle() {
    return Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.grey700, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPlan = 'monthly'),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: _selectedPlan == 'monthly'
                          ? LinearGradient(colors: AppColors.primaryGradient)
                          : null,
                      color: _selectedPlan == 'monthly'
                          ? null
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: _selectedPlan == 'monthly'
                          ? [
                              BoxShadow(
                                color: AppColors.primaryNeonOrange.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      'Monthly',
                      style: AppTypography.kSemiBold16.copyWith(
                        color: _selectedPlan == 'monthly'
                            ? AppColors.white
                            : AppColors.grey400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPlan = 'yearly'),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: _selectedPlan == 'yearly'
                          ? LinearGradient(colors: AppColors.primaryGradient)
                          : null,
                      color: _selectedPlan == 'yearly'
                          ? null
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: _selectedPlan == 'yearly'
                          ? [
                              BoxShadow(
                                color: AppColors.primaryNeonOrange.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Yearly',
                          style: AppTypography.kSemiBold16.copyWith(
                            color: _selectedPlan == 'yearly'
                                ? AppColors.white
                                : AppColors.grey400,
                          ),
                        ),
                        if (_selectedPlan == 'yearly') ...[
                          SizedBox(width: 4.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryNeonCyan.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: AppColors.primaryNeonCyan.withOpacity(
                                  0.5,
                                ),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Save 20%',
                              style: AppTypography.kMedium10.copyWith(
                                color: AppColors.primaryNeonCyan,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }

  Widget _buildPlanCard(int index) {
    final plan = _plans[index];
    final isSelected = _selectedTier == index;
    final isPopular = plan['popular'] as bool;

    return GestureDetector(
          onTap: () => setState(() => _selectedTier = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isSelected
                    ? (plan['gradient'] as List<Color>)
                    : [AppColors.cardDark, AppColors.cardDarker],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected
                    ? (plan['gradient'] as List<Color>).first.withOpacity(0.6)
                    : AppColors.grey700,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (plan['gradient'] as List<Color>).first
                            .withOpacity(0.4),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ]
                  : null,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Popular badge
                    if (isPopular)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.goldTierGlow,
                              AppColors.primaryNeonOrange,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldTierGlow.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Text(
                          'MOST POPULAR',
                          style: AppTypography.kMedium10.copyWith(
                            color: AppColors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                    if (isPopular) SizedBox(height: 12.h),

                    // Plan name
                    Text(
                      plan['name'] as String,
                      style: AppTypography.kBold24.copyWith(
                        color: AppColors.white,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          plan['price'] as String,
                          style: AppTypography.kBold32.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Text(
                            plan['period'] as String,
                            style: AppTypography.kRegular14.copyWith(
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Features
                    ...(plan['features'] as List<String>).map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryNeonCyan,
                                    AppColors.primaryNeonOrange,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Iconsax.tick_circle,
                                size: 14.w,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                feature,
                                style: AppTypography.kRegular14.copyWith(
                                  color: AppColors.grey300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    SizedBox(height: 20.h),

                    // Select indicator
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? Colors.white.withOpacity(0.3)
                              : AppColors.grey700,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSelected) ...[
                            Icon(
                              Iconsax.tick_circle,
                              size: 20.w,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Text(
                            isSelected ? 'Selected' : 'Select Plan',
                            style: AppTypography.kSemiBold16.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: index * 100),
        )
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }

  Widget _buildFeaturesSection() {
    return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.cardDark, AppColors.cardDarker],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.grey700, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Plans Include',
                style: AppTypography.kSemiBold18.copyWith(
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(
                    Iconsax.shield_tick,
                    size: 20.w,
                    color: AppColors.primaryNeonCyan,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Secure payment processing',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey300,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Iconsax.refresh,
                    size: 20.w,
                    color: AppColors.primaryNeonCyan,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Cancel anytime',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey300,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Iconsax.star,
                    size: 20.w,
                    color: AppColors.primaryNeonCyan,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      '7-day free trial',
                      style: AppTypography.kRegular14.copyWith(
                        color: AppColors.grey300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }

  void _handleSubscribe() {
    // TODO: Integrate with Stripe
    Get.snackbar(
      'Subscription',
      'Redirecting to Stripe checkout...',
      backgroundColor: AppColors.cardDark,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
