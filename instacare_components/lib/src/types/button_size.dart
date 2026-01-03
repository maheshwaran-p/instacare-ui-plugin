import 'package:flutter/material.dart';
enum ButtonSize { small, medium, large }
extension ButtonSizeExtension on ButtonSize {
  double get height => switch (this) { ButtonSize.small => 36, ButtonSize.medium => 48, ButtonSize.large => 56 };
  EdgeInsets get padding => switch (this) {
    ButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ButtonSize.large => const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
  };
}
