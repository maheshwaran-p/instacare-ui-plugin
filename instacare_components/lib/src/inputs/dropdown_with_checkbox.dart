import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareDropdownWithCheckbox<T> extends StatefulWidget {
  final List<T> items;
  final Set<T> selectedItems;
  final ValueChanged<Set<T>> onChanged;
  final String Function(T)? itemLabel;
  final String? hint;
  final String? label;
  final bool initiallyExpanded;

  const InstaCareDropdownWithCheckbox({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.itemLabel,
    this.hint,
    this.label,
    this.initiallyExpanded = false,
  });

  @override
  State<InstaCareDropdownWithCheckbox<T>> createState() =>
      _ICDropdownWithCheckboxState<T>();
}

class _ICDropdownWithCheckboxState<T>
    extends State<InstaCareDropdownWithCheckbox<T>> {
  late bool _expanded;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final selected = widget.selectedItems;
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final fieldTextSize = (width * 0.042).clamp(14.0, 16.0);
        final itemTextSize = (width * 0.04).clamp(14.0, 16.0);
        final maxListHeight =
            ((widget.items.length * 44.0) + 8).clamp(96.0, 220.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: InstaCareTypography.m
                    .copyWith(fontSize: fieldTextSize, color: AppColors.gray2),
              ),
              const SizedBox(height: 8),
            ],
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => setState(() => _expanded = !_expanded),
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  suffixIcon: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.gray4,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _expanded
                            ? AppColors.primary1
                            : AppColors.primary3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _expanded
                            ? AppColors.primary1
                            : AppColors.primary3),
                  ),
                ),
                child: Text(
                  widget.hint ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: InstaCareTypography.r.copyWith(
                    fontSize: fieldTextSize,
                    color: AppColors.gray5,
                  ),
                ),
              ),
            ),
            if (_expanded) ...[
              const SizedBox(height: 8),
              Container(
                constraints: BoxConstraints(maxHeight: maxListHeight),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primary3),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final isChecked = selected.contains(item);
                      final label =
                          widget.itemLabel?.call(item) ?? item.toString();

                      return Material(
                        color: isChecked ? AppColors.gray8 : Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            final next = Set<T>.from(selected);
                            if (isChecked) {
                              next.remove(item);
                            } else {
                              next.add(item);
                            }
                            widget.onChanged(next);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Checkbox(
                                    value: isChecked,
                                    onChanged: (_) {
                                      final next = Set<T>.from(selected);
                                      if (isChecked) {
                                        next.remove(item);
                                      } else {
                                        next.add(item);
                                      }
                                      widget.onChanged(next);
                                    },
                                    side: const BorderSide(
                                        color: AppColors.primary3),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    label,
                                    style: InstaCareTypography.r.copyWith(
                                        fontSize: itemTextSize,
                                        color: AppColors.gray2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
