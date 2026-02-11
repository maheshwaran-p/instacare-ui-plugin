import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCarePhoneInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String countryCode;
  final String countryIsoCode;

  const InstaCarePhoneInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.countryCode = '+91',
    this.countryIsoCode = 'IN',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final labelSize = (width * 0.042).clamp(14.0, 16.0);
        final textSize = (width * 0.05).clamp(15.0, 18.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[
              Text(
                label!,
                style: InstaCareTypography.m.copyWith(fontSize: labelSize, color: AppColors.gray2),
              ),
              const SizedBox(height: 8),
            ],
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              onChanged: onChanged,
              style: InstaCareTypography.m.copyWith(fontSize: textSize, color: AppColors.gray2),
              decoration: InputDecoration(
                hintText: hint ?? '87921 34521',
                hintStyle: InstaCareTypography.m.copyWith(fontSize: textSize, color: AppColors.gray5),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.baseWhite),
                          alignment: Alignment.center,
                          child: CountryFlag.fromCountryCode(
                            countryIsoCode,
                            width: 20,
                            height: 20,
                            borderRadius: 999,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down, size: 18),
                        const SizedBox(width: 10),
                        const SizedBox(
                          width: 1,
                          height: 30,
                          child: ColoredBox(color: AppColors.primary3),
                        ),
                        const SizedBox(width: 10),
                        Text(countryCode, style: InstaCareTypography.m.copyWith(fontSize: textSize, color: AppColors.gray2)),
                        const SizedBox(width: 6),
                      ],
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary1, width: 1.4),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

