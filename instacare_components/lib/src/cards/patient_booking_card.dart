import 'package:flutter/material.dart';
import 'card.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCarePatientBookingCard extends StatelessWidget {
  final String serviceName;
  final String dateTime;
  final Widget? serviceImage;
  final String patientLabel;
  final String partnerLabel;
  final String? partnerName;
  final Color? backgroundColor;

  const InstaCarePatientBookingCard({
    super.key,
    required this.serviceName,
    required this.dateTime,
    this.serviceImage,
    this.patientLabel = 'Patient',
    this.partnerLabel = 'Partner',
    this.partnerName,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final imageSize = (width * 0.22).clamp(64.0, 100.0);
        final avatarRadius = (width * 0.05).clamp(18.0, 26.0);

        return InstaCareCard(
          backgroundColor: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service info row
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: imageSize,
                      height: imageSize * 0.7,
                      child: serviceImage ??
                          Container(
                            color: AppColors.natural9,
                            child: const Icon(
                              Icons.medical_services_outlined,
                              color: AppColors.primary5,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceName,
                          style: InstaCareTypography.m.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateTime,
                          style: InstaCareTypography.s.copyWith(
                            color: AppColors.gray4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Patient-Partner connection
              Row(
                children: [
                  // Patient avatar
                  Column(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: AppColors.secondary7,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: avatarRadius * 0.9,
                          color: AppColors.secondary2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        patientLabel,
                        style: InstaCareTypography.xs.copyWith(
                          color: AppColors.gray4,
                        ),
                      ),
                    ],
                  ),
                  // Dotted line
                  Expanded(
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomPaint(
                        size: Size(double.infinity, 2),
                        painter: _DottedLinePainter(
                          color: AppColors.gray7,
                        ),
                      ),
                    ),
                  ),
                  // Partner avatar
                  Column(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: AppColors.gray8,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: avatarRadius * 0.9,
                          color: AppColors.gray5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        partnerName ?? 'Unassigned',
                        style: InstaCareTypography.xs.copyWith(
                          color: AppColors.gray4,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        partnerLabel,
                        style: InstaCareTypography.xs.copyWith(
                          color: AppColors.gray5,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  const _DottedLinePainter({required this.color}) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
