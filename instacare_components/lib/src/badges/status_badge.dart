import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

enum InstaCareStatusBadgeType {
  active,
  upcoming,
  cancelled,
  inTravel,
  completed,
  custom
}

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
        return AppColors.successBg;
      case InstaCareStatusBadgeType.upcoming:
        return AppColors.infoBg;
      case InstaCareStatusBadgeType.cancelled:
        return AppColors.errorBg;
      case InstaCareStatusBadgeType.inTravel:
        return AppColors.warningBg;
      case InstaCareStatusBadgeType.completed:
        return AppColors.completedBg;
      case InstaCareStatusBadgeType.custom:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  Color _textColor(BuildContext context) {
    switch (type) {
      case InstaCareStatusBadgeType.active:
        return AppColors.successFg;
      case InstaCareStatusBadgeType.upcoming:
        return AppColors.infoFg;
      case InstaCareStatusBadgeType.cancelled:
        return AppColors.errorFg;
      case InstaCareStatusBadgeType.inTravel:
        return AppColors.warningFg;
      case InstaCareStatusBadgeType.completed:
        return AppColors.completedFg;
      case InstaCareStatusBadgeType.custom:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: InstaCareTypography.sm.copyWith(
          fontWeight: FontWeight.w600,
          color: _textColor(context),
        ),
      ),
    );
  }
}
