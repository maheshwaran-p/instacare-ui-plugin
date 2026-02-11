import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareStepperItem {
  final String title;
  final String? description;

  const InstaCareStepperItem({required this.title, this.description});
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
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        final circleSize = (width / (items.length * 4.5)).clamp(28.0, 34.0);
        final stepNumberSize = (circleSize * 0.46).clamp(12.0, 15.0);
        final titleSize = (width * 0.05).clamp(13.0, 16.0);
        final descriptionSize = (width * 0.035).clamp(11.0, 12.0);
        final primary = Theme.of(context).colorScheme.primary;
        const inactive = AppColors.gray7;

        Color connectorColor(int beforeStepIndex) => beforeStepIndex < currentStep ? primary : inactive;
        Color circleColor(int stepIndex) => stepIndex <= currentStep ? primary : inactive;
        Color labelColor(int stepIndex) => stepIndex <= currentStep ? AppColors.gray2 : inactive;

        return Column(
          children: [
            Row(
              children: [
                for (int index = 0; index < items.length; index++) ...[
                  if (index > 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: connectorColor(index - 1),
                      ),
                    ),
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
                        ),
                      ),
                    ),
                  ),
                  if (index < items.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: connectorColor(index),
                      ),
                    ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (int index = 0; index < items.length; index++)
                  Expanded(
                    child: Column(
                      children: [
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
            ),
          ],
        );
      },
    );
  }
}

