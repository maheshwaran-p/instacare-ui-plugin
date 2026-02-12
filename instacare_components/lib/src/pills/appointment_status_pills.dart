import 'package:flutter/material.dart';
import '../badges/status_badge.dart';

class InstaCareAppointmentStatusPills extends StatelessWidget {
  final List<InstaCareStatusBadgeType> items;
  final InstaCareStatusBadgeType? selected;
  final ValueChanged<InstaCareStatusBadgeType>? onSelected;

  const InstaCareAppointmentStatusPills({
    super.key,
    this.items = const [
      InstaCareStatusBadgeType.active,
      InstaCareStatusBadgeType.upcoming,
      InstaCareStatusBadgeType.cancelled,
      InstaCareStatusBadgeType.inTravel,
      InstaCareStatusBadgeType.completed,
    ],
    this.selected,
    this.onSelected,
  });

  String _labelFor(InstaCareStatusBadgeType type) {
    switch (type) {
      case InstaCareStatusBadgeType.inTravel:
        return 'in-travel';
      default:
        return type.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((type) {
        final isSelected = selected == null || selected == type;
        final badge = InstaCareStatusBadge(label: _labelFor(type), type: type);

        if (onSelected == null) {
          return badge;
        }

        return Opacity(
          opacity: isSelected ? 1 : 0.65,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: () => onSelected?.call(type),
            child: badge,
          ),
        );
      }).toList(),
    );
  }
}
