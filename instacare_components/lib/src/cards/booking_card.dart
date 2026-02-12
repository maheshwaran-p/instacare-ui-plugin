import 'package:flutter/material.dart';
import '../badges/status_badge.dart';
import 'card.dart';
import '../theme/color.dart';
import '../theme/typography.dart';

class InstaCareBookingCard extends StatefulWidget {
  final String category;
  final String serviceName;
  final String patientName;
  final String bookingId;
  final String location;
  final String dateTime;
  final InstaCareStatusBadgeType status;
  final Color? backgroundColor;
  final bool showStateSelector;
  final int? stateIndex;

  const InstaCareBookingCard({
    super.key,
    required this.category,
    required this.serviceName,
    required this.patientName,
    required this.bookingId,
    required this.location,
    required this.dateTime,
    this.status = InstaCareStatusBadgeType.active,
    this.backgroundColor,
    this.showStateSelector = true,
    this.stateIndex,
  });

  @override
  State<InstaCareBookingCard> createState() => _InstaCareBookingCardState();
}

class _InstaCareBookingCardState extends State<InstaCareBookingCard> {
  int _selectedStateIndex = 0;

  List<_BookingStateData> _stateCards() {
    if (!widget.showStateSelector) {
      return [
        _BookingStateData(
          patientName: widget.patientName,
          status: widget.status,
        ),
      ];
    }

    return [
      _BookingStateData(
        patientName: widget.patientName,
        status: InstaCareStatusBadgeType.active,
      ),
      _BookingStateData(
        patientName: widget.patientName,
        status: InstaCareStatusBadgeType.inTravel,
        durationText: 'Duration : 1h 30m',
      ),
      const _BookingStateData(
        patientName: 'John Durai',
        status: InstaCareStatusBadgeType.upcoming,
      ),
      _BookingStateData(
        patientName: widget.patientName,
        status: InstaCareStatusBadgeType.completed,
        durationText: 'Duration : 1h 30m',
      ),
      _BookingStateData(
        patientName: widget.patientName,
        status: InstaCareStatusBadgeType.cancelled,
      ),
    ];
  }

  String _statusLabel(InstaCareStatusBadgeType status) {
    switch (status) {
      case InstaCareStatusBadgeType.inTravel:
        return 'In-Travel';
      default:
        return status.name[0].toUpperCase() + status.name.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final states = _stateCards();
    final effectiveIndex = widget.stateIndex == null
        ? _selectedStateIndex.clamp(0, states.length - 1)
        : widget.stateIndex!.clamp(0, states.length - 1);
    final selected = states[effectiveIndex];

    return InstaCareCard(
      backgroundColor: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.secondary7,
                child: Text(
                  selected.patientName.isNotEmpty
                      ? selected.patientName[0].toUpperCase()
                      : 'P',
                  style: InstaCareTypography.xs.copyWith(
                    color: AppColors.primary2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  selected.patientName,
                  style: InstaCareTypography.m
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              InstaCareStatusBadge(
                label: _statusLabel(selected.status),
                type: selected.status,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Booking ID: ${widget.bookingId}',
                  style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
                ),
              ),
              if (selected.durationText != null)
                Text(
                  selected.durationText!,
                  style:
                      InstaCareTypography.s.copyWith(color: AppColors.infoFg),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gray8,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${widget.category} - ${widget.serviceName}',
              style: InstaCareTypography.s.copyWith(color: AppColors.gray2),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 14, color: AppColors.gray5),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.location,
                  style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today_outlined,
                  size: 13, color: AppColors.gray5),
              const SizedBox(width: 4),
              Text(
                widget.dateTime,
                style: InstaCareTypography.s.copyWith(color: AppColors.gray4),
              ),
            ],
          ),
          if (widget.showStateSelector &&
              widget.stateIndex == null &&
              states.length > 1) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(states.length, (index) {
                final isSelected = _selectedStateIndex == index;
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => setState(() => _selectedStateIndex = index),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '${index + 1}',
                      style: InstaCareTypography.m.copyWith(
                        color:
                            isSelected ? AppColors.primary2 : AppColors.gray4,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}

class _BookingStateData {
  final String patientName;
  final InstaCareStatusBadgeType status;
  final String? durationText;

  const _BookingStateData({
    required this.patientName,
    required this.status,
    this.durationText,
  });
}
