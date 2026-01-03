import 'package:flutter/material.dart';
class ICInfoCard extends StatelessWidget {
  final Widget? leading, trailing;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  const ICInfoCard({super.key, this.leading, required this.title, this.subtitle, this.trailing, this.onTap});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [if (leading != null) ...[leading!, const SizedBox(width: 12)], Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)), if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: theme.textTheme.bodyMedium)]])), if (trailing != null) ...[const SizedBox(width: 12), trailing!]]))));
  }
}
