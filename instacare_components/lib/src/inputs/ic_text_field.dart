import 'package:flutter/material.dart';

class ICTextField extends StatefulWidget {
  final String? label, hint;
  final TextEditingController? controller;
  final bool obscureText, enabled, showPasswordToggle;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  const ICTextField({super.key, this.label, this.hint, this.controller, this.obscureText = false, this.keyboardType, this.prefixIcon, this.onChanged, this.maxLines = 1, this.enabled = true, this.showPasswordToggle = false});
  const ICTextField.password({super.key, this.label, this.hint, this.controller, this.onChanged, this.enabled = true}) : obscureText = true, keyboardType = null, prefixIcon = Icons.lock_outline, maxLines = 1, showPasswordToggle = true;

  @override
  State<ICTextField> createState() => _ICTextFieldState();
}

class _ICTextFieldState extends State<ICTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      if (widget.label != null) ...[Text(widget.label!, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)), const SizedBox(height: 8)],
      TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        maxLines: _obscureText ? 1 : widget.maxLines,
        enabled: widget.enabled,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.showPasswordToggle && widget.obscureText ? IconButton(icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => _obscureText = !_obscureText)) : null,
          counterText: '',
        ),
      ),
    ]);
  }
}
