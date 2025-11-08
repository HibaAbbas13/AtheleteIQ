import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class FadeInWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: duration, delay: delay);
  }
}


class SlideFromTopWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double begin;

  const SlideFromTopWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.begin = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: duration, delay: delay).slideY(
          begin: begin,
          end: 0,
          duration: duration,
          curve: Curves.easeOut,
        );
  }
}


class SlideFromLeftWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double begin;

  const SlideFromLeftWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.begin = -0.2,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: duration, delay: delay).slideX(
          begin: begin,
          end: 0,
          duration: duration,
          curve: Curves.easeOut,
        );
  }
}

/// Slide from right animation wrapper
class SlideFromRightWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double begin;

  const SlideFromRightWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.begin = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: duration, delay: delay).slideX(
          begin: begin,
          end: 0,
          duration: duration,
          curve: Curves.easeOut,
        );
  }
}

/// Scale animation wrapper
class ScaleInWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const ScaleInWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.elasticOut,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().scale(duration: duration, delay: delay, curve: curve);
  }
}

/// Combined fade and slide animation wrapper
class FadeSlideWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double slideBegin;
  final Axis axis;

  const FadeSlideWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideBegin = 0.2,
    this.axis = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      return child.animate().fadeIn(duration: duration, delay: delay).slideY(
            begin: slideBegin,
            end: 0,
            duration: duration,
            curve: Curves.easeOut,
          );
    } else {
      return child.animate().fadeIn(duration: duration, delay: delay).slideX(
            begin: slideBegin,
            end: 0,
            duration: duration,
            curve: Curves.easeOut,
          );
    }
  }
}

/// Staggered animation for list items
class StaggeredListItem extends StatelessWidget {
  final Widget child;
  final int index;
  final int baseDelayMs;
  final int itemDelayMs;

  const StaggeredListItem({
    super.key,
    required this.child,
    required this.index,
    this.baseDelayMs = 200,
    this.itemDelayMs = 50,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: baseDelayMs + (index * itemDelayMs)),
        )
        .slideX(
          begin: -0.1,
          end: 0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
  }
}

/// Scale with fade animation for cards
class ScaleFadeWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const ScaleFadeWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: duration, delay: delay).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: duration,
          curve: Curves.easeOut,
        );
  }
}

