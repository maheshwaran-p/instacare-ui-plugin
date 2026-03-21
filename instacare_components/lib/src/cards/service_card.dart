import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String priceText;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color titleColor;
  final Color bodyColor;
  final Color accentColor;

  const InstaCareServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.priceText,
    this.onTap,
    this.backgroundColor = AppColors.serviceCardBackground,
    this.titleColor = AppColors.serviceCardTitle,
    this.bodyColor = AppColors.serviceCardBody,
    this.accentColor = AppColors.serviceCardAccent,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final height =
            constraints.maxHeight.isFinite ? constraints.maxHeight : 146.0;
        final widthScale = (width / 320).clamp(0.72, 1.35);
        final heightScale = (height / 146).clamp(0.72, 1.35);
        final scale = math.min(widthScale, heightScale);

        final radius = (10 * scale).clamp(8.0, 14.0);
        final horizontalPadding = (16 * widthScale).clamp(10.0, 22.0);
        final verticalPadding = (14 * heightScale).clamp(8.0, 18.0);
        final gapLarge = (8 * scale).clamp(4.0, 10.0);
        final gapSmall = (2 * scale).clamp(1.0, 4.0);
        final titleSize = (24 * scale).clamp(16.0, 30.0);
        final bodySize = (16 * scale).clamp(12.0, 18.0);
        final priceSize = (24 * scale).clamp(14.0, 26.0);
        final leafWidth = (width * 0.22).clamp(48.0, 90.0);
        final leafInset = (10 * scale).clamp(6.0, 12.0);
        final reservedRight = leafWidth + (leafInset * 1.4);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radius),
            child: Ink(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DotTexturePainter(
                        color: AppColors.baseWhite.withValues(alpha: 0.09),
                        cutOffRight: reservedRight,
                        spacing: (10 * scale).clamp(7.0, 12.0),
                        radius: (0.8 * scale).clamp(0.6, 1.2),
                      ),
                    ),
                  ),
                  Positioned(
                    right: leafInset,
                    top: leafInset,
                    bottom: leafInset,
                    width: leafWidth,
                    child: CustomPaint(
                      painter: _LeafPainter(
                        color: accentColor.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      verticalPadding,
                      reservedRight - (leafInset * 0.6),
                      verticalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          maxLines: width < 250 ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: InstaCareTypography.h1.copyWith(
                            color: titleColor,
                            fontSize: titleSize,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: gapLarge),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: InstaCareTypography.body.copyWith(
                            color: bodyColor,
                            fontSize: bodySize,
                          ),
                        ),
                        SizedBox(height: gapSmall),
                        Text(
                          priceText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: InstaCareTypography.h3.copyWith(
                            color: bodyColor,
                            fontSize: priceSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DotTexturePainter extends CustomPainter {
  final Color color;
  final double cutOffRight;
  final double spacing;
  final double radius;

  const _DotTexturePainter({
    required this.color,
    required this.cutOffRight,
    required this.spacing,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final maxX = size.width - cutOffRight;
    final startY = spacing + 4;
    final endY = size.height - spacing;

    for (double y = startY; y < endY; y += spacing) {
      final rowOffset = ((y / spacing).floor().isEven) ? 0.0 : spacing / 2;
      for (double x = spacing + rowOffset; x < maxX; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotTexturePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.cutOffRight != cutOffRight ||
      oldDelegate.spacing != spacing ||
      oldDelegate.radius != radius;
}

class _LeafPainter extends CustomPainter {
  final Color color;

  const _LeafPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final stemPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final leafPaint = Paint()..color = color.withValues(alpha: 0.8);

    final stem = Path()
      ..moveTo(size.width * 0.48, size.height * 0.98)
      ..quadraticBezierTo(
        size.width * 0.42,
        size.height * 0.62,
        size.width * 0.62,
        size.height * 0.24,
      );
    canvas.drawPath(stem, stemPaint);

    final points = <Offset>[
      Offset(size.width * 0.57, size.height * 0.72),
      Offset(size.width * 0.63, size.height * 0.60),
      Offset(size.width * 0.66, size.height * 0.49),
      Offset(size.width * 0.64, size.height * 0.38),
      Offset(size.width * 0.58, size.height * 0.30),
    ];

    for (int i = 0; i < points.length; i++) {
      final p = points[i];
      final scale = 1 - (i * 0.08);
      _drawLeaf(canvas, leafPaint, p, 17 * scale, -math.pi / 6);
    }

    final leftPoints = <Offset>[
      Offset(size.width * 0.50, size.height * 0.64),
      Offset(size.width * 0.52, size.height * 0.52),
      Offset(size.width * 0.55, size.height * 0.42),
    ];

    for (int i = 0; i < leftPoints.length; i++) {
      final p = leftPoints[i];
      final scale = 0.9 - (i * 0.08);
      _drawLeaf(canvas, leafPaint, p, 15 * scale, -math.pi + (math.pi / 6));
    }
  }

  void _drawLeaf(
      Canvas canvas, Paint paint, Offset center, double length, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(length * 0.45, -length * 0.45, length, 0)
      ..quadraticBezierTo(length * 0.45, length * 0.45, 0, 0);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LeafPainter oldDelegate) =>
      oldDelegate.color != color;
}
