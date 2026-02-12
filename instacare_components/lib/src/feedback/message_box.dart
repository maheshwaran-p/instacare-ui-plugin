import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

enum InstaCareMessageType { info, error, pending, success }

class InstaCareMessageBox extends StatelessWidget {
  final InstaCareMessageType type;
  final String title;
  final String body;

  const InstaCareMessageBox({
    super.key,
    required this.type,
    required this.title,
    required this.body,
  });

  IconData get _icon {
    switch (type) {
      case InstaCareMessageType.info:
        return Icons.info_outline;
      case InstaCareMessageType.error:
        return Icons.error_outline;
      case InstaCareMessageType.pending:
        return Icons.hourglass_top;
      case InstaCareMessageType.success:
        return Icons.check_circle_outline;
    }
  }

  Color _backgroundColor() {
    switch (type) {
      case InstaCareMessageType.info:
        return AppColors.infoBg;
      case InstaCareMessageType.error:
        return AppColors.errorBg;
      case InstaCareMessageType.pending:
        return AppColors.warningBg;
      case InstaCareMessageType.success:
        return AppColors.successBg;
    }
  }

  Color _foregroundColor() {
    switch (type) {
      case InstaCareMessageType.info:
        return AppColors.infoFg;
      case InstaCareMessageType.error:
        return AppColors.errorFg;
      case InstaCareMessageType.pending:
        return AppColors.warningFg;
      case InstaCareMessageType.success:
        return AppColors.successFg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fg = _foregroundColor();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_icon, size: 18, color: fg),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: InstaCareTypography.s.copyWith(
                    fontWeight: FontWeight.w700,
                    color: fg,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: InstaCareTypography.xs.copyWith(color: fg),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
