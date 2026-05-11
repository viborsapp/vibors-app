import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// The Vibors V-mark — diagonal motif drawn as a CustomPainter so it
/// scales crisp at any size and renders identically across platforms.
///
/// Geometry: two angled bars forming a V, with the right bar carrying
/// a subtle brand gradient (primary → accent) to give depth.
class VMark extends StatelessWidget {
  const VMark({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _VMarkPainter(),
      ),
    );
  }
}

class _VMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Stroke width scales with size — 12% of the mark.
    final strokeWidth = w * 0.16;

    // Left bar — solid primary.
    final leftPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Right bar — gradient primary → accent for visual lift.
    final rightPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, AppColors.accent],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // V geometry — apex sits slightly below center for optical balance.
    final apexY = h * 0.78;
    final topY = h * 0.18;
    final inset = w * 0.18;

    final leftPath = Path()
      ..moveTo(inset, topY)
      ..lineTo(w / 2, apexY);

    final rightPath = Path()
      ..moveTo(w / 2, apexY)
      ..lineTo(w - inset, topY);

    canvas.drawPath(leftPath, leftPaint);
    canvas.drawPath(rightPath, rightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
