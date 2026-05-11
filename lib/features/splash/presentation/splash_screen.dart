import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'widgets/v_mark.dart';

/// Vibors Splash Screen.
///
/// Animation spec (matches Figma Splash Animation Prototype):
///   0.00–0.20s  Deep violet base fade-in
///   0.20–0.60s  V-mark slide-in from bottom-left + fade
///   0.40–0.90s  Wordmark "VIBORS" fade + subtle scale (1.0 → 1.02 → 1.0)
///   0.70–1.30s  Ambient glow pulse on V-mark
///   1.30–1.60s  Cross-fade out → next screen
///
/// Tap anywhere after 0.8s to skip.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  // Phase animations driven by the master controller.
  late final Animation<double> _baseFade;
  late final Animation<Offset> _vMarkSlide;
  late final Animation<double> _vMarkFade;
  late final Animation<double> _wordmarkFade;
  late final Animation<double> _wordmarkScale;
  late final Animation<double> _glowPulse;
  late final Animation<double> _exitFade;

  static const Duration _total = Duration(milliseconds: 1600);
  static const Duration _minBeforeSkip = Duration(milliseconds: 800);

  bool _canSkip = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _total);

    // Material-standard easing across all phases.
    const ease = Curves.easeInOutCubic;

    _baseFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.000, 0.125, curve: Curves.easeOut),
      ),
    );

    _vMarkSlide = Tween<Offset>(
      begin: const Offset(-0.2, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.125, 0.375, curve: ease),
      ),
    );

    _vMarkFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.125, 0.375, curve: ease),
      ),
    );

    _wordmarkFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.250, 0.563, curve: ease),
      ),
    );

    _wordmarkScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.02), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.02, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.250, 0.563, curve: ease),
      ),
    );

    _glowPulse = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.4), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.438, 0.813, curve: ease),
      ),
    );

    _exitFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.813, 1.000, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Enable skip after the min threshold.
    Future.delayed(_minBeforeSkip, () {
      if (mounted) setState(() => _canSkip = true);
    });

    // After the full animation, route to next.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        _next();
      }
    });
  }

  void _trySkip() {
    if (!_canSkip) return;
    _controller.value = 0.813; // jump to exit fade
    _controller.forward();
  }

  void _next() {
    // TODO(routing): replace with session-aware decision (signed-in → /home,
    // signed-out → /auth/sign-in). For scaffold we route to /auth.
    if (!mounted) return;
    context.go('/auth');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _trySkip,
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Opacity(
              opacity: _exitFade.value,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.backgroundRadial,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow halo behind V-mark.
                    Opacity(
                      opacity: _glowPulse.value.clamp(0.0, 1.0) * 0.7,
                      child: Container(
                        width: 360,
                        height: 360,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.brandGlow,
                        ),
                      ),
                    ),

                    // Base fade wash.
                    Opacity(
                      opacity: _baseFade.value,
                      child: const SizedBox.expand(),
                    ),

                    // V-mark + wordmark lockup.
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeTransition(
                          opacity: _vMarkFade,
                          child: SlideTransition(
                            position: _vMarkSlide,
                            child: const VMark(size: 120),
                          ),
                        ),
                        const SizedBox(height: 32),
                        FadeTransition(
                          opacity: _wordmarkFade,
                          child: ScaleTransition(
                            scale: _wordmarkScale,
                            child: Text(
                              'VIBORS',
                              style: AppTypography.wordmarkStyle.copyWith(
                                fontSize: 36,
                                letterSpacing: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
