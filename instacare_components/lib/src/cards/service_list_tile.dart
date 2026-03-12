import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareServiceAssets {
  InstaCareServiceAssets._();

  static const String _base =
      'packages/instacare_components/src/assessts_patient';
  static const String nursing = '$_base/nursing.png';
  static const String physiotherapy = '$_base/physiotheraphy.png';
  static const String caretaker = '$_base/caretaker.png';
  static const String liveinCare = '$_base/liveincare.png';
}

class InstaCareServiceListItem {
  final String name;
  final String duration;
  final String price;
  final String description;
  final String? imageAsset;
  final Widget? image;
  final bool isNew;

  const InstaCareServiceListItem({
    required this.name,
    required this.duration,
    required this.price,
    required this.description,
    this.imageAsset,
    this.image,
    this.isNew = false,
  });
}

class InstaCareServiceListTile extends StatelessWidget {
  final List<InstaCareServiceListItem> items;
  final String newBadgeLabel;
  final ValueChanged<InstaCareServiceListItem>? onItemTap;

  const InstaCareServiceListTile({
    super.key,
    required this.items,
    this.newBadgeLabel = 'New',
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          _ServiceTile(
            item: items[i],
            newBadgeLabel: newBadgeLabel,
            onTap: () => onItemTap?.call(items[i]),
          ),
          if (i < items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final InstaCareServiceListItem item;
  final String newBadgeLabel;
  final VoidCallback? onTap;

  const _ServiceTile({
    required this.item,
    required this.newBadgeLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.baseWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary8, width: 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 90,
                height: 90,
                child: item.image ??
                    (item.imageAsset != null
                        ? Image.asset(
                            item.imageAsset!,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          )
                        : Container(
                            color: AppColors.natural9,
                            child: const Center(
                              child: Icon(
                                Icons.medical_services_outlined,
                                size: 32,
                                color: AppColors.primary5,
                              ),
                            ),
                          )),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: InstaCareTypography.m.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.isNew) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.ivory1,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            newBadgeLabel,
                            style: InstaCareTypography.xs.copyWith(
                              color: AppColors.ivory1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColors.gray5,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${item.duration} | ${item.price}',
                          style: InstaCareTypography.s.copyWith(
                            color: AppColors.gray3,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: InstaCareTypography.s.copyWith(
                      color: AppColors.gray5,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
