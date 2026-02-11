import 'package:flutter/material.dart';

class InstaCareBottomNavItem {
  final IconData icon;
  final String label;

  const InstaCareBottomNavItem({required this.icon, required this.label});
}

class InstaCareBottomAppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<InstaCareBottomNavItem> items;

  const InstaCareBottomAppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: items
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

