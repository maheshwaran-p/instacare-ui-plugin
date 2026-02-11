import 'package:flutter/material.dart';

class InstaCareCardGridView extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;

  const InstaCareCardGridView({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: children,
    );
  }
}

