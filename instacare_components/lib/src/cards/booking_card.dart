import 'package:flutter/material.dart';
import '../badges/status_badge.dart';
import 'card.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareBookingCard extends StatelessWidget {
  final String category;
  final String serviceName;
  final String patientName;
  final String bookingId;
  final String location;
  final String dateTime;
  final String? durationText;
  final InstaCareStatusBadgeType status;
  final Color? backgroundColor;

  const InstaCareBookingCard({
    super.key,
    required this.category,
    required this.serviceName,
    required this.patientName,
    required this.bookingId,
    required this.location,
    required this.dateTime,
    this.durationText,
    this.status = InstaCareStatusBadgeType.active,
    this.backgroundColor,
  });

  String _statusLabel(InstaCareStatusBadgeType status) {
    switch (status) {
      case InstaCareStatusBadgeType.inTravel:
        return 'In-Travel';
      default:
        return status.name[0].toUpperCase() + status.name.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InstaCareCard(
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.secondary7,
                child: Text(
                  patientName.isNotEmpty ? patientName[0].toUpperCase() : 'P',
                  style: InstaCareTypography.xs.copyWith(
                    color: AppColors.primary2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  patientName,
                  style: InstaCareTypography.m
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              InstaCareStatusBadge(
                label: _statusLabel(status),
                type: status,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Booking ID: $bookingId',
                  style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
                ),
              ),
              if (durationText != null)
                Text(
                  durationText!,
                  style:
                      InstaCareTypography.s.copyWith(color: AppColors.infoFg),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gray8,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$category - $serviceName',
              style: InstaCareTypography.s.copyWith(color: AppColors.gray2),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 14, color: AppColors.gray5),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today_outlined,
                  size: 13, color: AppColors.gray5),
              const SizedBox(width: 4),
              Text(
                dateTime,
                style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
