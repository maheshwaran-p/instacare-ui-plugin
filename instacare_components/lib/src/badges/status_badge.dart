import 'package:flutter/material.dart';

enum InstaCareStatusBadgeType { active, upcoming, cancelled, inTravel, completed, custom }

class InstaCareStatusBadge extends StatelessWidget {
  final String label;
  final InstaCareStatusBadgeType type;

  const InstaCareStatusBadge({
    super.key,
    required this.label,
    this.type = InstaCareStatusBadgeType.custom,
  });

  Color _backgroundColor(BuildContext context) {
    switch (type) {
      case InstaCareStatusBadgeType.active:
        return const Color(0xFFE8F7ED);
      case InstaCareStatusBadgeType.upcoming:
        return const Color(0xFFE8F1FF);
      case InstaCareStatusBadgeType.cancelled:
        return const Color(0xFFFFECEC);
      case InstaCareStatusBadgeType.inTravel:
        return const Color(0xFFFFF6E5);
      case InstaCareStatusBadgeType.completed:
        return const Color(0xFFEDEBFF);
      case InstaCareStatusBadgeType.custom:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  Color _textColor(BuildContext context) {
    switch (type) {
      case InstaCareStatusBadgeType.active:
        return const Color(0xFF1E7F43);
      case InstaCareStatusBadgeType.upcoming:
        return const Color(0xFF1D4ED8);
      case InstaCareStatusBadgeType.cancelled:
        return const Color(0xFFB42318);
      case InstaCareStatusBadgeType.inTravel:
        return const Color(0xFF9A6700);
      case InstaCareStatusBadgeType.completed:
        return const Color(0xFF5B21B6);
      case InstaCareStatusBadgeType.custom:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _textColor(context),
        ),
      ),
    );
  }
}

