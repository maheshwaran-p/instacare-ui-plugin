import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemLabel;
  final bool initiallyExpanded;

  const InstaCareDropdown({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.itemLabel,
    this.initiallyExpanded = false,
  });

  @override
  State<InstaCareDropdown<T>> createState() => _InstaCareDropdownState<T>();
}

class _InstaCareDropdownState<T> extends State<InstaCareDropdown<T>> {
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
    final selectedText = widget.value == null
        ? (widget.hint ?? '')
        : (widget.itemLabel?.call(widget.value as T) ?? widget.value.toString());

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
                _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
              selectedText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: InstaCareTypography.r.copyWith(
                color: widget.value == null ? AppColors.gray6 : AppColors.gray2,
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
                  final isSelected = widget.value == item;
                  final label = widget.itemLabel?.call(item) ?? item.toString();

                  return Material(
                    color: isSelected ? AppColors.gray8 : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.onChanged?.call(item);
                        setState(() => _expanded = false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          label,
                          style: InstaCareTypography.r.copyWith(
                            color: isSelected ? AppColors.gray1 : AppColors.gray2,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
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

