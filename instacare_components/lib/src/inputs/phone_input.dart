import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/countries.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCarePhoneInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<PhoneNumber>? onChanged;
  final String initialCountryCode;
  final String? errorText;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final FormFieldValidator<PhoneNumber>? validator;
  final AutovalidateMode? autovalidateMode;

  const InstaCarePhoneInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.initialCountryCode = 'IN',
    this.errorText,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<InstaCarePhoneInput> createState() => _InstaCarePhoneInputState();
}

class _InstaCarePhoneInputState extends State<InstaCarePhoneInput> {
  int _currentLength = 0;
  int _maxLength = 10;

  @override
  void initState() {
    super.initState();
    _currentLength = widget.controller?.text.length ?? 0;
    
    // Set initial max length based on initial country code
    try {
      final initialCountry = countries.firstWhere(
        (c) => c.code == widget.initialCountryCode,
        orElse: () => countries.firstWhere((c) => c.code == 'IN'),
      );
      _maxLength = initialCountry.maxLength;
    } catch (_) {
      _maxLength = 10;
    }

    widget.controller?.addListener(_updateLength);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateLength);
    super.dispose();
  }

  void _updateLength() {
    if (mounted) {
      setState(() {
        _currentLength = widget.controller?.text.length ?? 0;
      });
    }
  }

  static const double _radius = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: InstaCareTypography.r.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 8),
        ],
        IntlPhoneField(
          controller: widget.controller,
          initialCountryCode: widget.initialCountryCode,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          onChanged: (phone) {
            setState(() {
              _currentLength = phone.number.length;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(phone);
            }
          },
          onCountryChanged: (country) {
            setState(() {
              _maxLength = country.maxLength;
            });
          },
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          style: InstaCareTypography.r.copyWith(
            color: AppColors.primary900,
          ),
          dropdownTextStyle: InstaCareTypography.r.copyWith(
            color: AppColors.primary900,
          ),
          flagsButtonPadding: const EdgeInsets.only(left: 8),
          dropdownIconPosition: IconPosition.trailing,
          decoration: InputDecoration(
            hintText: 'Enter phone number',
            hintStyle: InstaCareTypography.r.copyWith(
              color: AppColors.gray400,
            ),
            errorText: widget.errorText,
            filled: true,
            fillColor: AppColors.ivory300,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(color: AppColors.primary700),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(color: AppColors.primary700),
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
            counter: Text(
              '$_currentLength/$_maxLength',
              style: InstaCareTypography.xs.copyWith(
                color: AppColors.gray500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
