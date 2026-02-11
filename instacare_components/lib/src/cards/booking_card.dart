import 'package:flutter/material.dart';
import '../badges/status_badge.dart';
import 'card.dart';

class InstaCareBookingCard extends StatelessWidget {
  final String category;
  final String serviceName;
  final String patientName;
  final String bookingId;
  final String location;
  final String dateTime;
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
    this.status = InstaCareStatusBadgeType.active,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InstaCareCard(
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$category - $serviceName',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              InstaCareStatusBadge(label: status.name, type: status),
            ],
          ),
          const SizedBox(height: 8),
          Text(patientName),
          const SizedBox(height: 4),
          Text('Booking ID: $bookingId', style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 8),
          Text(location, style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 4),
          Text(dateTime, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}


