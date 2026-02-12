import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareBottomNavItem {
  final IconData icon;
  final String label;

  const InstaCareBottomNavItem({required this.icon, required this.label});
}

class InstaCareBottomAppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<InstaCareBottomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? topBorderColor;
  final bool showShadow;

  const InstaCareBottomAppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.topBorderColor,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const resolvedOuterBackground = AppColors.baseWhite;
    final resolvedInnerBackground = backgroundColor ?? AppColors.ivory7;
    final resolvedSelected = selectedItemColor ?? theme.colorScheme.primary;
    final resolvedUnselected = unselectedItemColor ?? AppColors.primary6;
    final resolvedBorder = topBorderColor ?? AppColors.primary2;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: resolvedOuterBackground,
        border: Border(top: BorderSide(color: resolvedBorder)),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppColors.gray1.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: resolvedInnerBackground,
          selectedItemColor: resolvedSelected,
          unselectedItemColor: resolvedUnselected,
          selectedLabelStyle:
              InstaCareTypography.xs.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              InstaCareTypography.xs.copyWith(fontWeight: FontWeight.w500),
          items: items
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
