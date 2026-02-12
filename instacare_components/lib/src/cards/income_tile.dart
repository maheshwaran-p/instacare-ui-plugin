import 'package:flutter/material.dart';
import 'card.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareIncomeTile extends StatelessWidget {
  final String title;
  final String amount;
  final VoidCallback? onRedeem;
  final Color? backgroundColor;

  const InstaCareIncomeTile({
    super.key,
    required this.title,
    required this.amount,
    this.onRedeem,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InstaCareCard(
      backgroundColor: backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
                ),
                const SizedBox(height: 6),
                Text(
                  amount,
                  style: InstaCareTypography.h2
                      .copyWith(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          if (onRedeem != null)
            TextButton(onPressed: onRedeem, child: const Text('Redeem')),
        ],
      ),
    );
  }
}
