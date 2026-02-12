import 'package:flutter/material.dart';
import 'pill_chip.dart';

class InstaCareFilterPills extends StatelessWidget {
  final List<String> items;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const InstaCareFilterPills({
    super.key,
    required this.items,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selected.contains(item);
        return InstaCarePillChip(
          label: item,
          selected: isSelected,
          onTap: () => onToggle(item),
        );
      }).toList(),
    );
  }
}
