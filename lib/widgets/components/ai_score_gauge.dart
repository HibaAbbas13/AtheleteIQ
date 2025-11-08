import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import '../../data/app_colors.dart';
import '../../utils/score_utils.dart';
import '../../widgets/animations/animated_widgets.dart';

class AIScoreGauge extends StatefulWidget {
  final int score; // 1-100
  final double size;
  final bool animate;

  const AIScoreGauge({
    super.key,
    required this.score,
    this.size = 250,
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


  @override
  Widget build(BuildContext context) {
    final animatedScoreInt = _animatedScore.toInt();
    final scoreColor = ScoreUtils.getScoreColor(animatedScoreInt);
    final progress = _animatedScore / 100;

    return ScaleFadeWidget(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 200),
      child: Container(
      width: widget.size.w,
      height: widget.size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            scoreColor.withOpacity(0.15),
            scoreColor.withOpacity(0.05),
            Colors.transparent
          ],
          stops: const [0.3, 0.6, 1.0],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widget.size.w * 0.95,
            height: widget.size.w * 0.95,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: scoreColor.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: scoreColor.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          Container(
            width: widget.size.w * 0.88,
            height: widget.size.w * 0.88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  scoreColor.withOpacity(0.3),
                  scoreColor.withOpacity(0.15),
                  scoreColor.withOpacity(0.05),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          SizedBox(
            width: widget.size.w * 0.85,
            height: widget.size.w * 0.85,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 16,
              backgroundColor: AppColors.grey200.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.grey200.withOpacity(0.3),
              ),
            ),
          ),

          Transform.rotate(
                angle: -math.pi / 2,
                child: SizedBox(
                  width: widget.size.w * 0.85,
                  height: widget.size.w * 0.85,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 16,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                  ),
                ),
              )
              .animate(target: widget.animate ? 1 : 0)
              .shimmer(duration: 2000.ms, color: scoreColor.withOpacity(0.6)),
  
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _animatedScore.toInt().toString(),
                style: TextStyle(
                  fontSize: 72.sp,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                  letterSpacing: -2,
                  shadows: [
                    Shadow(
                      color: scoreColor.withOpacity(0.4),
                      blurRadius: 20,
                    ),
                    Shadow(
                      color: scoreColor.withOpacity(0.2),
                      blurRadius: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'AI ReScore',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey500,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: scoreColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  ScoreUtils.getScoreLabel(animatedScoreInt),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: scoreColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}

