import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareSearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InstaCareSearchBar({
    super.key,
    this.hint = 'Search',
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;

        // 🔹 Adaptive values
        final height = (width * 0.13).clamp(44.0, 56.0);
        final horizontalPadding =
            (width * 0.04).clamp(12.0, 18.0);
        final iconSize = (width * 0.06).clamp(20.0, 24.0);
        final fontSize = (width * 0.045).clamp(14.0, 16.0);
        final radius = (width * 0.04).clamp(10.0, 14.0);

        return SizedBox(
          height: height,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: InstaCareTypography.r.copyWith(fontSize: fontSize),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: InstaCareTypography.r.copyWith(
                fontSize: fontSize,
                color: AppColors.gray4,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: iconSize,
                color: AppColors.gray4,
              ),
              filled: true,
              fillColor: AppColors.ivory7,
              contentPadding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide:
                    const BorderSide(color: AppColors.primary3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide:
                    const BorderSide(color: AppColors.primary3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(
                  color: AppColors.primary1,
                  width: 1.6,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
