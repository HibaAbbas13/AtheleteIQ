import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import '../../data/app_colors.dart';
import '../../data/app_typography.dart';

class AIScoreGauge extends StatefulWidget {
  final int score; // 1-100
  final double size;
  final bool animate;

  const AIScoreGauge({
    super.key,
    required this.score,
    this.size = 200,
    this.animate = true,
  });

  @override
  State<AIScoreGauge> createState() => _AIScoreGaugeState();
}

class _AIScoreGaugeState extends State<AIScoreGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _animatedScore = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.score.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _animation.addListener(() {
      setState(() {
        _animatedScore = _animation.value;
      });
    });

    if (widget.animate) {
      _controller.forward();
    } else {
      _animatedScore = widget.score.toDouble();
    }
  }

  @override
  void didUpdateWidget(AIScoreGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score && widget.animate) {
      _controller.reset();
      _animation =
          Tween<double>(
            begin: _animatedScore,
            end: widget.score.toDouble(),
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getScoreColor() {
    if (_animatedScore >= 90) {
      return AppColors.platinumTierGlow;
    } else if (_animatedScore >= 80) {
      return AppColors.goldTierGlow;
    } else if (_animatedScore >= 70) {
      return AppColors.silverTierGlow;
    } else if (_animatedScore >= 60) {
      return AppColors.bronzeTierGlow;
    } else {
      return AppColors.primaryNeonOrange;
    }
  }

  String _getScoreLabel() {
    if (_animatedScore >= 90) {
      return 'Elite';
    } else if (_animatedScore >= 80) {
      return 'Excellent';
    } else if (_animatedScore >= 70) {
      return 'Good';
    } else if (_animatedScore >= 60) {
      return 'Fair';
    } else {
      return 'Improving';
    }
  }

  @override
  Widget build(BuildContext context) {
    final scoreColor = _getScoreColor();
    final progress = _animatedScore / 100;

    return Container(
      width: widget.size.w,
      height: widget.size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [scoreColor.withOpacity(0.2), Colors.transparent],
        ),
        boxShadow: [
          BoxShadow(
            color: scoreColor.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: widget.size.w,
            height: widget.size.w,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 12,
              backgroundColor: AppColors.grey800,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.grey800),
            ),
          ),

          // Animated progress
          Transform.rotate(
                angle: -math.pi / 2,
                child: SizedBox(
                  width: widget.size.w,
                  height: widget.size.w,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                  ),
                ),
              )
              .animate(target: widget.animate ? 1 : 0)
              .shimmer(duration: 2000.ms, color: scoreColor.withOpacity(0.5)),

          // Score text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _animatedScore.toInt().toString(),
                style: AppTypography.kBold32.copyWith(
                  color: scoreColor,
                  shadows: [
                    Shadow(color: scoreColor.withOpacity(0.5), blurRadius: 10),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'AI ReScore',
                style: AppTypography.kRegular12.copyWith(
                  color: AppColors.grey400,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _getScoreLabel(),
                style: AppTypography.kMedium12.copyWith(color: scoreColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
