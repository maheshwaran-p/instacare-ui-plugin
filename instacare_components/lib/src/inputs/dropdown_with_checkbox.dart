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
    final selected = widget.selectedItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: InstaCareTypography.s.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray2,
            ),
          ),
          const SizedBox(height: 8),
        ],
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => setState(() => _expanded = !_expanded),
          child: InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.ivory7,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: Icon(
                _expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.gray4,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary1,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              widget.hint ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: InstaCareTypography.r.copyWith(
                color: AppColors.gray6,
              ),
            ),
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 220.0),
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
                            horizontal: 12, vertical: 10),
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
                                  color: AppColors.gray2,
                                ),
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
  }
}
