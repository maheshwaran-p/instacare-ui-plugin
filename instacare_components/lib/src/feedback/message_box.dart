import 'package:flutter/material.dart';

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
        return const Color(0xFFEAF2FF);
      case InstaCareMessageType.error:
        return const Color(0xFFFFECEC);
      case InstaCareMessageType.pending:
        return const Color(0xFFFFF6E5);
      case InstaCareMessageType.success:
        return const Color(0xFFE8F7ED);
    }
  }

  Color _foregroundColor() {
    switch (type) {
      case InstaCareMessageType.info:
        return const Color(0xFF1D4ED8);
      case InstaCareMessageType.error:
        return const Color(0xFFB42318);
      case InstaCareMessageType.pending:
        return const Color(0xFF9A6700);
      case InstaCareMessageType.success:
        return const Color(0xFF1E7F43);
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
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: fg,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(color: fg, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

