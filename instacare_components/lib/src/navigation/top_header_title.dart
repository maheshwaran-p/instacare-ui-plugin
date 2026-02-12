import 'package:flutter/material.dart';

class InstaCareTopHeaderTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  const InstaCareTopHeaderTitle({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: onBack == null ? null : IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: onBack),
      actions: actions,
    );
  }
}

