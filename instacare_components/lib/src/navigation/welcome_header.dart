import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareWelcomeHeader extends StatelessWidget {
  final String userName;
  final String searchHint;
  final VoidCallback? onSearchTap;
  final VoidCallback? onAvatarTap;

  const InstaCareWelcomeHeader({
    super.key,
    required this.userName,
    this.searchHint = 'What care do you need today?',
    this.onSearchTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final avatarRadius = (width * 0.07).clamp(22.0, 32.0);
        final nameSize = (width * 0.055).clamp(18.0, 24.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onAvatarTap,
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: AppColors.secondary5,
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: avatarRadius * 1.1,
                      color: AppColors.baseWhite,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Welcome, $userName',
                    style: InstaCareTypography.h1.copyWith(
                      fontSize: nameSize,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: onSearchTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.ivory8,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondary6, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        searchHint,
                        style: InstaCareTypography.r.copyWith(
                          color: AppColors.gray6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.auto_awesome_outlined,
                      size: 22,
                      color: AppColors.secondary4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
