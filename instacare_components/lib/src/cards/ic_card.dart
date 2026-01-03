import 'package:flutter/material.dart';
class ICCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  const ICCard({super.key, required this.child, this.padding, this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Padding(padding: padding ?? const EdgeInsets.all(16), child: child)));
}
