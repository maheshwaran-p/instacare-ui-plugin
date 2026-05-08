import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCarePhoneInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String countryCode;
  final String countryIsoCode;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final int maxDigits;
  final ValueChanged<Country>? onCountryChanged;

  const InstaCarePhoneInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.countryCode = '+91',
    this.countryIsoCode = 'IN',
    this.errorText,
    this.validator,
    this.maxDigits = 10,
    this.onCountryChanged,
  });

  // ───── Design tokens (matching InstaCareTextField) ─────
  static const double _radius = 8;
  static const double _flagSize = 20;

  static const double _outerPadding = 16;
  static const double _smallGap = 8;
  static const double _codeGap = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: InstaCareTypography.r.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 8),
        ],

        TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          onChanged: onChanged,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }
                if (value.length != maxDigits) {
                  return 'Phone number must be $maxDigits digits';
                }
                return null;
              },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxDigits),
          ],
          style: InstaCareTypography.r.copyWith(
            color: AppColors.primary900,
            height: 1.0,
          ),
          decoration: InputDecoration(
            hintText: hint ?? '87921 34521',
            hintStyle: InstaCareTypography.r.copyWith(
              color: AppColors.gray400,
              height: 1.0,
            ),
            errorText: errorText,

            /// IMPORTANT: remove default 48px constraint
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),

            /// ───── Prefix ─────
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: _outerPadding),
              child: InkWell(
                onTap: onCountryChanged != null
                    ? () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            borderRadius: BorderRadius.circular(12),
                            backgroundColor: AppColors.baseWhite,
                            textStyle: InstaCareTypography.r.copyWith(
                              color: AppColors.gray800,
                            ),
                            searchTextStyle: InstaCareTypography.r.copyWith(
                              color: AppColors.gray800,
                            ),
                            inputDecoration: InputDecoration(
                              hintText: 'Search country',
                              hintStyle: InstaCareTypography.r.copyWith(
                                color: AppColors.gray400,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: AppColors.ivory300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.primary700,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.primary700,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.primary900,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          onSelect: onCountryChanged!,
                        );
                      }
                    : null,
                borderRadius: BorderRadius.circular(4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Flag with vertical alignment fix
                    Transform.translate(
                      offset: const Offset(0, -1),
                      child: CountryFlag.fromCountryCode(
                        countryIsoCode,
                        width: _flagSize,
                        height: _flagSize,
                        borderRadius: 999,
                      ),
                    ),

                    const SizedBox(width: _smallGap),

                    // Country code
                    Text(
                      countryCode,
                      style: InstaCareTypography.r.copyWith(
                        height: 1.0,
                      ),
                    ),

                    // Dropdown indicator if callback is provided
                    if (onCountryChanged != null) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: AppColors.gray600,
                      ),
                    ],

                    const SizedBox(width: _codeGap),
                  ],
                ),
              ),
            ),

            filled: true,
            fillColor: AppColors.ivory300,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide:
                  const BorderSide(color: AppColors.primary700),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide:
                  const BorderSide(color: AppColors.primary700),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(
                color: AppColors.primary900,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(color: AppColors.error700),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(
                color: AppColors.error700,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
