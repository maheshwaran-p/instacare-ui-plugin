import 'package:flutter/material.dart';
import 'color.dart';
import 'typography.dart';

/// InstaCare Heading Components
/// Provides consistent heading styles across the app
class InstaCareHeading {
  /// Top Header Title - Used for main page headers
  static Widget topHeaderTitle(String text) {
    return Text(
      text,
      style: InstaCareTypography.h1.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.gray2,
      ),
    );
  }

  /// Title with Back Button - Used for navigation headers
  static Widget titleWithBackButton({
    required String text,
    VoidCallback? onBackPressed,
  }) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.gray1,
            size: 28,
          ),
          onPressed: onBackPressed,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: InstaCareTypography.h2.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.gray1,
          ),
        ),
      ],
    );
  }
}
