import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// The Vibors V-mark — the geometric flag/leaf "V" symbol from the brand.
///
/// Two stacked diagonal shapes:
///   - Left: a bright violet flag (parallelogram) angled down-right
///   - Right: a deeper navy flag angled down-left, joining at the bottom apex
/// Together they form a stylised lowercase "v".
///
/// This is the SMALL inline version used in the wordmark lockup. The large
/// architectural V at the bottom of the splash is rendered separately as
/// [SplashVArchitecture].
class VMark extends StatelessWidget {
  const VMark({
    super.key,
    this.size = 32,
    this.primaryColor = AppColors.primary,
  });

  final double size;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * (52 / 59), // matches Figma 52:59 aspect ratio
      height: size,
      child: CustomPaint(
        painter: _VMarkPainter(primaryColor),
      ),
    );
  }
}

class _VMarkPainter extends CustomPainter {
  _VMarkPainter(this.primary);

  final Color primary;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Left "flag" — bright violet parallelogram pointing down-right.
    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(w * 0.42, 0)
      ..lineTo(w * 0.58, h)
      ..lineTo(w * 0.16, h)
      ..close();

    final leftPaint = Paint()
      ..color = primary
      ..isAntiAlias = true;

    // Right "flag" — slightly darker violet, mirror angled.
    final rightPath = Path()
      ..moveTo(w * 0.58, h)
      ..lineTo(w * 0.74, h * 0.35)
      ..lineTo(w * 1.00, h * 0.35)
      ..lineTo(w * 0.84, h)
      ..close();

    final rightPaint = Paint()
      ..color = Color.lerp(primary, Colors.black, 0.35)!
      ..isAntiAlias = true;

    canvas.drawPath(leftPath, leftPaint);
    canvas.drawPath(rightPath, rightPaint);
  }

  @override
  bool shouldRepaint(covariant _VMarkPainter oldDelegate) =>
      oldDelegate.primary != primary;
}

/// The dramatic 3D V architecture rendered at the bottom of the splash.
///
/// This is a stylised representation of the Figma rendered hero — two large
/// extruded wings of the V converging at the bottom apex, with subtle ridge
/// highlights and inner shadow to suggest depth on the dark violet background.
class SplashVArchitecture extends StatelessWidget {
  const SplashVArchitecture({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ArchitecturePainter(),
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ─── Left wing of the V ────────────────────────────────────────
    // Starts at top-left edge, angles down-right to the apex.
    final leftWingPath = Path()
      ..moveTo(-w * 0.1, h * 0.20)
      ..lineTo(w * 0.55, h * 1.05)
      ..lineTo(w * 0.35, h * 1.05)
      ..lineTo(-w * 0.3, h * 0.30)
      ..close();

    final leftWingPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primary.withValues(alpha: 0.85),
          AppColors.deep,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(leftWingPath, leftWingPaint);

    // Highlight ridge along the inner edge of the left wing.
    final leftRidgePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final leftRidge = Path()
      ..moveTo(-w * 0.1, h * 0.20)
      ..lineTo(w * 0.55, h * 1.05);
    canvas.drawPath(leftRidge, leftRidgePaint);

    // ─── Right wing of the V ───────────────────────────────────────
    final rightWingPath = Path()
      ..moveTo(w * 1.1, h * 0.05)
      ..lineTo(w * 0.50, h * 1.05)
      ..lineTo(w * 0.70, h * 1.05)
      ..lineTo(w * 1.3, h * 0.15)
      ..close();

    final rightWingPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          AppColors.primary.withValues(alpha: 0.55),
          AppColors.deep,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(rightWingPath, rightWingPaint);

    final rightRidgePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final rightRidge = Path()
      ..moveTo(w * 1.1, h * 0.05)
      ..lineTo(w * 0.50, h * 1.05);
    canvas.drawPath(rightRidge, rightRidgePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
