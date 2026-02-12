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

class InstaCareVerticalStepper extends StatefulWidget {
  final List<InstaCareStepperItem> items;
  final int currentStep;
  final ValueChanged<int>? onStepChanged;
  final Duration animationDuration;

  const InstaCareVerticalStepper({
    super.key,
    required this.items,
    required this.currentStep,
    this.onStepChanged,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<InstaCareVerticalStepper> createState() => _InstaCareVerticalStepperState();
}

class _InstaCareVerticalStepperState extends State<InstaCareVerticalStepper>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.items.length - 1,
      (index) => AnimationController(
        vsync: this,
        duration: widget.animationDuration,
        value: index < widget.currentStep ? 1.0 : 0.0,
      ),
    );

    _animations = _controllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            ))
        .toList();
  }

  @override
  void didUpdateWidget(InstaCareVerticalStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.currentStep != widget.currentStep) {
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      if (i < widget.currentStep) {
        _controllers[i].forward();
      } else {
        _controllers[i].reverse();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;

        final circleSize = (width / (widget.items.length * 4)).clamp(26.0, 38.0);
        final stepNumberSize = (circleSize * 0.45).clamp(12.0, 16.0);
        final titleSize = (width * 0.045).clamp(13.0, 16.0);
        final descriptionSize = (width * 0.035).clamp(11.0, 12.0);

        final primary = Theme.of(context).colorScheme.primary;
        const inactive = AppColors.gray7;

        Color circleColor(int index) =>
            index <= widget.currentStep ? primary : inactive;
        Color labelColor(int index) =>
            index <= widget.currentStep ? AppColors.gray2 : inactive;

        return Row(
          children: [
            for (int index = 0; index < widget.items.length; index++)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: circleSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Left connector
                          if (index > 0)
                            Positioned(
                              left: 0,
                              right: circleSize / 2,
                              child: _AnimatedConnector(
                                animation: _animations[index - 1],
                                activeColor: primary,
                                inactiveColor: inactive,
                                isCompleted: index - 1 < widget.currentStep,
                              ),
                            ),
                          // Right connector
                          if (index < widget.items.length - 1)
                            Positioned(
                              left: circleSize / 2,
                              right: 0,
                              child: _AnimatedConnector(
                                animation: _animations[index],
                                activeColor: primary,
                                inactiveColor: inactive,
                                isCompleted: index < widget.currentStep,
                                showArrow: true,
                              ),
                            ),
                          // Circle
                          InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () => widget.onStepChanged?.call(index),
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
                    Text(
                      widget.items[index].title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: InstaCareTypography.m.copyWith(
                        color: labelColor(index),
                        fontSize: titleSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (widget.items[index].description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.items[index].description!,
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

class _AnimatedConnector extends StatelessWidget {
  final Animation<double> animation;
  final Color activeColor;
  final Color inactiveColor;
  final bool isCompleted;
  final bool showArrow;

  const _AnimatedConnector({
    required this.animation,
    required this.activeColor,
    required this.inactiveColor,
    required this.isCompleted,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background (inactive) line
        Container(
          height: 2,
          color: inactiveColor,
        ),
        // Animated (active) line
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: animation.value,
                child: Container(
                  height: 2,
                  color: activeColor,
                ),
              ),
            );
          },
        ),
        // Arrow
        if (showArrow)
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Positioned(
                right: 0,
                child: Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: isCompleted ? activeColor : inactiveColor,
                ),
              );
            },
          ),
      ],
    );
  }
}