import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_colors.dart';

enum CardType { elevated, outlined, filled }

enum CardSize { small, medium, large }

class CustomCard extends StatelessWidget {
  final Widget child;
  final CardType type;
  final CardSize size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;
  final bool animateOnTap;

  const CustomCard({
    Key? key,
    required this.child,
    this.type = CardType.elevated,
    this.size = CardSize.medium,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.shadows,
    this.onTap,
    this.animateOnTap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.symmetric(vertical: 8.h),
      padding: padding ?? _getPadding(),
      decoration: _getDecoration(context),
      child: child,
    );

    final animatedCard = card
        .animate()
        .fadeIn(duration: 400.ms, delay: 100.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOut);

    if (onTap != null) {
      return InkWell(
        onTap: animateOnTap
            ? () {
                onTap!();
              }
            : onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        child: animateOnTap
            ? animatedCard
                  .animate(target: animateOnTap ? 1 : 0)
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(0.98, 0.98),
                    duration: 100.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    begin: const Offset(0.98, 0.98),
                    end: const Offset(1, 1),
                    duration: 100.ms,
                    curve: Curves.easeInOut,
                  )
            : animatedCard,
      );
    }

    return animatedCard;
  }

  BoxDecoration _getDecoration(BuildContext context) {
    final baseDecoration = BoxDecoration(
      color: backgroundColor ?? AppColors.white,
      borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
    );

    switch (type) {
      case CardType.elevated:
        return baseDecoration.copyWith(
          boxShadow:
              shadows ??
              [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
        );

      case CardType.outlined:
        return baseDecoration.copyWith(
          border: Border.all(color: borderColor ?? AppColors.grey300, width: 1),
        );

      case CardType.filled:
        return baseDecoration;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case CardSize.small:
        return EdgeInsets.all(12.w);
      case CardSize.medium:
        return EdgeInsets.all(16.w);
      case CardSize.large:
        return EdgeInsets.all(24.w);
    }
  }
}

class ScoreCard extends StatelessWidget {
  final int score;
  final String label;
  final Color? scoreColor;
  final String? subtitle;
  final IconData? icon;

  const ScoreCard({
    Key? key,
    required this.score,
    required this.label,
    this.scoreColor,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CardType.elevated,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 32.w, color: scoreColor ?? AppColors.primaryBlue),
            SizedBox(height: 8.h),
          ],
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: scoreColor ?? AppColors.primaryBlue,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.getTextSecondary(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.getTextSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final Color? unlockedColor;

  const AchievementCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
    this.unlockedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      type: CardType.outlined,
      backgroundColor: isUnlocked
          ? (unlockedColor ?? AppColors.success).withOpacity(0.05)
          : null,
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? (unlockedColor ?? AppColors.success).withOpacity(0.1)
                  : AppColors.grey200,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: isUnlocked
                  ? (unlockedColor ?? AppColors.success)
                  : AppColors.grey500,
              size: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked
                        ? AppColors.getTextPrimary(context)
                        : AppColors.grey500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isUnlocked
                        ? AppColors.getTextSecondary(context)
                        : AppColors.grey400,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked) ...[
            SizedBox(width: 12.w),
            Icon(
              Icons.check_circle,
              color: unlockedColor ?? AppColors.success,
              size: 24.w,
            ),
          ],
        ],
      ),
    );
  }
}
