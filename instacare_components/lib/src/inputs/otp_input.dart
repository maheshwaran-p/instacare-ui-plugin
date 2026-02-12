import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareOtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  const InstaCareOtpInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<InstaCareOtpInput> createState() => _ICOtpInputState();
}

class _ICOtpInputState extends State<InstaCareOtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otpValue => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        const spacing = 8.0;
        final totalSpacing = (widget.length - 1) * spacing;
        final cell = ((width - totalSpacing) / widget.length).clamp(44.0, 56.0);
        final fontSize = (cell * 0.42).clamp(18.0, 24.0);

        return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center, // ✅ force alignment
  children: List.generate(widget.length, (index) {
    return Padding(
      padding: EdgeInsets.only(
        right: index == widget.length - 1 ? 0 : spacing,
      ),
      child: SizedBox(
        width: cell,
        height: cell,
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: InstaCareTypography.h3.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.ivory7,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary1,
                width: 2,
              ),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < widget.length - 1) {
              _focusNodes[index + 1].requestFocus();
            }

            widget.onChanged?.call(_otpValue);

            if (_otpValue.length == widget.length) {
              widget.onCompleted?.call(_otpValue);
            }
          },
          onTap: () {
            _controllers[index].selection = TextSelection.fromPosition(
              TextPosition(offset: _controllers[index].text.length),
            );
          },
        ),
      ),
    );
  }),
);

      },
    );
  }
}
