import 'package:flutter/material.dart';
import '../types/button_size.dart';

class ICButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize size;
  final IconData? icon;
  final bool fullWidth;
  final _ButtonVariant _variant;

  const ICButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.size = ButtonSize.medium, this.icon, this.fullWidth = false}) : _variant = _ButtonVariant.primary;
  const ICButton.secondary({super.key, required this.text, this.onPressed, this.isLoading = false, this.size = ButtonSize.medium, this.icon, this.fullWidth = false}) : _variant = _ButtonVariant.secondary;
  const ICButton.text({super.key, required this.text, this.onPressed, this.isLoading = false, this.size = ButtonSize.medium, this.icon, this.fullWidth = false}) : _variant = _ButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget child = isLoading
        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(_variant == _ButtonVariant.primary ? theme.colorScheme.onPrimary : theme.colorScheme.primary)))
        : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)], Text(text)]);
    return SizedBox(height: size.height, width: fullWidth ? double.infinity : null, child: _buildButton(context, child));
  }

  Widget _buildButton(BuildContext context, Widget child) => switch (_variant) {
    _ButtonVariant.primary => ElevatedButton(onPressed: isLoading ? null : onPressed, style: ElevatedButton.styleFrom(padding: size.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: child),
    _ButtonVariant.secondary => OutlinedButton(onPressed: isLoading ? null : onPressed, style: OutlinedButton.styleFrom(padding: size.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: child),
    _ButtonVariant.text => TextButton(onPressed: isLoading ? null : onPressed, style: TextButton.styleFrom(padding: size.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: child),
  };
}

enum _ButtonVariant { primary, secondary, text }
