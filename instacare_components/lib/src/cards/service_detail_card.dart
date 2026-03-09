import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareServiceDetailCard extends StatelessWidget {
  final String serviceName;
  final String duration;
  final String price;
  final String description;
  final Widget? serviceImage;
  final String moreDetailsLabel;
  final String bookNowLabel;
  final VoidCallback? onMoreDetails;
  final VoidCallback? onBookNow;

  const InstaCareServiceDetailCard({
    super.key,
    required this.serviceName,
    required this.duration,
    required this.price,
    required this.description,
    this.serviceImage,
    this.moreDetailsLabel = 'More Details >',
    this.bookNowLabel = 'Book Now',
    this.onMoreDetails,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final imageHeight = (width * 0.42).clamp(100.0, 180.0);
        final titleSize = (width * 0.045).clamp(14.0, 18.0);
        final bodySize = (width * 0.038).clamp(12.0, 14.0);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.baseWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary8, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: image + service info
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(11),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: imageHeight,
                        child: serviceImage ??
                            Container(
                              color: AppColors.natural9,
                              child: const Center(
                                child: Icon(
                                  Icons.medical_services_outlined,
                                  size: 40,
                                  color: AppColors.primary5,
                                ),
                              ),
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceName,
                            style: InstaCareTypography.m.copyWith(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                              Text(
                                '$duration | $price',
                                style: InstaCareTypography.s.copyWith(
                                  fontSize: bodySize,
                                  color: AppColors.gray4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Right: description + buttons
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        description,
                        style: InstaCareTypography.s.copyWith(
                          fontSize: bodySize,
                          color: AppColors.gray3,
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 14),
                      OutlinedButton(
                        onPressed: onMoreDetails,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary3,
                          side: const BorderSide(
                            color: AppColors.primary7,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          moreDetailsLabel,
                          style: InstaCareTypography.sm.copyWith(
                            color: AppColors.primary3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: onBookNow,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary3,
                          backgroundColor: AppColors.primary9,
                          side: const BorderSide(
                            color: AppColors.primary5,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          bookNowLabel,
                          style: InstaCareTypography.sm.copyWith(
                            color: AppColors.primary2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
