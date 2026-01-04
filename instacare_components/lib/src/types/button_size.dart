import 'package:flutter/material.dart';
enum ButtonSize { small, medium, large }
extension ButtonSizeExtension on ButtonSize {
  double get height => switch (this) { 
    ButtonSize.small => 40, 
    ButtonSize.medium => 48, 
    ButtonSize.large => 56 
  };
  EdgeInsets get padding => switch (this) {
    ButtonSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ButtonSize.large => const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  };
}
