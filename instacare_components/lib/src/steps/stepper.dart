import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareStepperItem {
  final String title;
  final String? description;

  const InstaCareStepperItem({
    required this.title,
    this.description,
  });
}

class InstaCareVerticalStepper extends StatelessWidget {
  final List<InstaCareStepperItem> items;
  final int currentStep;
  final ValueChanged<int>? onStepChanged;

  const InstaCareVerticalStepper({
    super.key,
    required this.items,
    required this.currentStep,
    this.onStepChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;

        final circleSize =
            (width / (items.length * 4)).clamp(26.0, 38.0);
        final stepNumberSize =
            (circleSize * 0.45).clamp(12.0, 16.0);
        final titleSize = (width * 0.045).clamp(13.0, 16.0);
        final descriptionSize = (width * 0.035).clamp(11.0, 12.0);

        final primary = Theme.of(context).colorScheme.primary;
        const inactive = AppColors.gray7;

        Color circleColor(int index) =>
            index <= currentStep ? primary : inactive;

        Color connectorColor(int index) =>
            index < currentStep ? primary : inactive;

        Color labelColor(int index) =>
            index <= currentStep ? AppColors.gray2 : inactive;

        return Row(
          children: [
            for (int index = 0; index < items.length; index++)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// ───── Circle + connector (STACK FIX) ─────
                    SizedBox(
                      height: circleSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          /// Connector (right side only)
                          if (index < items.length - 1)
                            Positioned(
                              left: circleSize / 2,
                              right: 0,
                              child: Container(
                                height: 2,
                                color: connectorColor(index),
                              ),
                            ),

                          /// Circle (TRUE CENTER)
                          InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () => onStepChanged?.call(index),
                            child: Container(
                              width: circleSize,
                              height: circleSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: circleColor(index),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: InstaCareTypography.sm.copyWith(
                                  color: AppColors.baseWhite,
                                  fontSize: stepNumberSize,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// ───── Title (now PERFECTLY centered) ─────
                    Text(
                      items[index].title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: InstaCareTypography.m.copyWith(
                        color: labelColor(index),
                        fontSize: titleSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    if (items[index].description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        items[index].description!,
                        textAlign: TextAlign.center,
                        style: InstaCareTypography.s.copyWith(
                          color: AppColors.gray4,
                          fontSize: descriptionSize,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
