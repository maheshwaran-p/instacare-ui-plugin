import 'package:flutter/material.dart';
import 'pill_chip.dart';

class InstaCareServicePills extends StatelessWidget {
  final List<String> services;
  final String? selected;
  final ValueChanged<String> onSelected;

  const InstaCareServicePills({
    super.key,
    required this.services,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: services.map((service) {
        final isSelected = service == selected;
        return InstaCarePillChip(
          label: service,
          selected: isSelected,
          onTap: () => onSelected(service),
        );
      }).toList(),
    );
  }
}
