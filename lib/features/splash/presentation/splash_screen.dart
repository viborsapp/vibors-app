import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import 'widgets/v_mark.dart';

/// Vibors Splash Screen — matches Figma "Splash Screen Logo view" frame.
///
/// Composition (bottom-up):
///   1. Deep violet → bright violet radial background
///   2. Dramatic 3D V architecture rendered across the bottom 60% of the screen
///   3. Centred "v vibors™" lockup (small V-mark + white wordmark)
///
/// Animation (1.6s total) follows the Figma sequence:
///   0.00–0.30s  Background fades in from black
///   0.30–0.80s  V architecture rises into place + brightens
///   0.60–1.10s  Lockup fades in + subtle scale 0.95 → 1.00
///   1.30–1.60s  Cross-fade out before routing to next screen
///
/// Tap after 0.8s to skip.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _bgFade;
  late final Animation<double> _archRise;
  late final Animation<double> _archFade;
  late final Animation<double> _lockupFade;
  late final Animation<double> _lockupScale;
  late final Animation<double> _exitFade;

  static const Duration _total = Duration(milliseconds: 1600);
  static const Duration _minBeforeSkip = Duration(milliseconds: 800);

  bool _canSkip = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _total);

    _bgFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.000, 0.188, curve: Curves.easeOut),
      ),
    );

    _archRise = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.188, 0.500, curve: Curves.easeOutCubic),
      ),
    );

    _archFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.188, 0.500, curve: Curves.easeOut),
      ),
    );

    _lockupFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.375, 0.688, curve: Curves.easeOut),
      ),
    );

    _lockupScale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.375, 0.688, curve: Curves.easeOutCubic),
      ),
    );

    _exitFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.813, 1.000, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Future.delayed(_minBeforeSkip, () {
      if (mounted) setState(() => _canSkip = true);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        _next();
      }
    });
  }

  void _trySkip() {
    if (!_canSkip) return;
    _controller.value = 0.813;
    _controller.forward();
  }

  void _next() {
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
        backgroundColor: Colors.black,
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Opacity(
              opacity: _exitFade.value,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ── Background: violet → deep navy radial gradient ──
                  Opacity(
                    opacity: _bgFade.value,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(-0.2, -0.6),
                          radius: 1.6,
                          colors: [
                            AppColors.primary,
                            Color(0xFF2A0080),
                            AppColors.deep,
                          ],
                          stops: [0.0, 0.45, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // ── V architecture across the bottom half ──
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Transform.translate(
                      offset: Offset(0, _archRise.value),
                      child: Opacity(
                        opacity: _archFade.value,
                        child: const SplashVArchitecture(),
                      ),
                    ),
                  ),

                  // ── Centred "v vibors™" lockup ──
                  Center(
                    child: FractionalTranslation(
                      translation: const Offset(0, -0.4),
                      child: Opacity(
                        opacity: _lockupFade.value,
                        child: Transform.scale(
                          scale: _lockupScale.value,
                          child: const _VibrosLockup(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// "v vibors™" lockup — the actual logo as it appears on the splash.
///
/// Uses the exported Figma asset for crisp rendering. The asset is the dark
/// variant; we recolour it to white via [ColorFiltered] to read against the
/// violet background.
class _VibrosLockup extends StatelessWidget {
  const _VibrosLockup();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Small V-mark — coloured in primary violet.
        const VMark(size: 36),
        const SizedBox(width: 10),
        // Wordmark "vibors™".
        Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              'vibors',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.5,
                height: 1.0,
                fontFeatures: const [FontFeature.disable('liga')],
              ),
            ),
            const Positioned(
              right: -16,
              top: 2,
              child: Text(
                'TM',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
