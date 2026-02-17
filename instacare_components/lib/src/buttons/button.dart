import 'package:flutter/material.dart';
import '../animation/skeleton_loading.dart';
import '../types/button_size.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize size;
  final IconData? icon;
  final bool fullWidth;
  final _ButtonVariant _variant;
  final bool isDisabled;

  const InstaCareButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
    this.isDisabled = false,
  }) : _variant = _ButtonVariant.primary;

  const InstaCareButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
    this.isDisabled = false,
  }) : _variant = _ButtonVariant.secondary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final textSize = (width * 0.045).clamp(13.0, 16.0);
        final iconSize = (width * 0.05).clamp(16.0, 18.0);
        final skeletonWidth = (width * 0.34).clamp(56.0, 120.0);
        final textColor = _variant == _ButtonVariant.primary
            ? AppColors.baseWhite
            : AppColors.gray2;

        final Widget child = isLoading
            ? InstaCareSkeletonLoading(
                height: 12,
                width: skeletonWidth,
                borderRadius: const BorderRadius.all(Radius.circular(999)),
                baseColor: _variant == _ButtonVariant.primary
                    ? AppColors.baseWhite.withValues(alpha: 0.24)
                    : AppColors.gray8,
                highlightColor: _variant == _ButtonVariant.primary
                    ? AppColors.baseWhite.withValues(alpha: 0.6)
                    : AppColors.baseWhite,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: iconSize, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: InstaCareTypography.r
                          .copyWith(fontSize: textSize, color: textColor),
                    ),
                  ),
                ],
              );

        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height < 48 ? 48 : size.height,
            minWidth: fullWidth ? width : 0,
          ),
          child: _buildButton(context, child),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, Widget child) {
    final theme = Theme.of(context);

    switch (_variant) {
      case _ButtonVariant.primary:
        return ElevatedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: AppColors.baseWhite,
            padding: size.padding,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: child,
        );
      case _ButtonVariant.secondary:
        return OutlinedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.gray2,
            backgroundColor: AppColors.primary8,
            padding: size.padding,
            side: BorderSide(
              color: isDisabled ? AppColors.gray6 : theme.colorScheme.primary,
              width: 1.2,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: child,
        );
    }
  }
}

enum _ButtonVariant { primary, secondary }
