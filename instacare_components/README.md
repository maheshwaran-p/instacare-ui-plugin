# Instacare Components

Reusable Flutter UI component library for Instacare applications.

This package provides a single import for design tokens and ready-to-use widgets (buttons, inputs, cards, feedback, navigation, pills, steps, dialogs, upload, and loading states).

## Package Info

- Package: `instacare_components`
- Version: `1.0.0`
- Dart SDK: `>=3.0.0 <4.0.0`
- Flutter: `>=3.16.0`
- Extra dependency: `country_flags`

## Project Structure

```text
instacare_components/
  lib/
    instacare_components.dart        # Public export barrel
    src/
      animation/
        skeleton_loading.dart
      badges/
        status_badge.dart
      buttons/
        button.dart
      cards/
        booking_card.dart
        card.dart
        card_list_view.dart
        income_tile.dart
        service_card.dart
      dialogs/
        confirmation_dialog.dart
      feedback/
        message_box.dart
        progress_bar.dart
      inputs/
        checkbox_field.dart
        date_picker_field.dart
        dropdown.dart
        dropdown_with_checkbox.dart
        otp_input.dart
        phone_input.dart
        search_bar.dart
        text_field.dart
      navigation/
        bottom_app_nav_bar.dart
        top_header_title.dart
      pills/
        appointment_status_pills.dart
        hours_summary_pill.dart
      selection/
        filter_pills.dart
        mcq_option_selector.dart
        pill_chip.dart
        radio_buttons.dart
        rating_scale.dart
        service_pills.dart
      steps/
        stepper.dart
      theme/
        color.dart
        typography.dart
      types/
        button_size.dart
      upload/
        file_upload_tile.dart
  example/
    lib/
      main.dart                      # Component gallery/demo page
      themes/
        partner_theme.dart
        user_theme.dart
```

## Installation

Add dependency in your app `pubspec.yaml`:

```yaml
dependencies:
  instacare_components:
    path: ../instacare_components
```

Run:

```bash
flutter pub get
```

Import:

```dart
import 'package:instacare_components/instacare_components.dart';
```

## What Is Exported

Use only this single import file:
- `lib/instacare_components.dart`

It exports:
- `AppColors`, `InstaCareTypography`, `ButtonSize`
- All UI widgets in `src/*`

## Component Catalog

### Theme / Tokens
- `AppColors`
- `InstaCareTypography`
- `ButtonSize`

### Animation
- `InstaCareSkeletonLoading`

### Buttons
- `InstaCareButton`
- `InstaCareButton.secondary`

### Inputs
- `InstaCareTextField`
- `InstaCareOtpInput`
- `InstaCarePhoneInput`
- `InstaCareDropdown`
- `InstaCareDropdownWithCheckbox`
- `InstaCareDatePickerField`
- `InstaCareCheckboxField`
- `InstaCareSearchBar`

### Selection
- `InstaCareRadioButtons`
- `InstaCareMcqOptionSelector`
- `InstaCareServicePills`
- `InstaCareFilterPills`
- `InstaCareRatingScale`
- `InstaCarePillChip`

### Cards
- `InstaCareCard`
- `InstaCareBookingCard`
- `InstaCareIncomeTile`
- `InstaCareCardListView`
- `InstaCareServiceCard`

### Feedback
- `InstaCareMessageBox`
- `InstaCareProgressBar`

### Badges / Pills / Steps / Upload
- `InstaCareStatusBadge`
- `InstaCareHoursSummaryPill`
- `InstaCareAppointmentStatusPills`
- `InstaCareVerticalStepper`
- `InstaCareFileUploadTile`

### Navigation
- `InstaCareTopHeaderTitle`
- `InstaCareBottomAppNavBar`

### Dialog
- `showInstaCareConfirmationDialog(...)`

## Usage Examples

### 1) Basic Screen

```dart
import 'package:flutter/material.dart';
import 'package:instacare_components/instacare_components.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InstaCareTopHeaderTitle(title: 'Instacare Demo'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InstaCareButton(text: 'Continue', onPressed: () {}),
            const SizedBox(height: 12),
            const InstaCareTextField(label: 'Email', hint: 'Enter your email'),
            const SizedBox(height: 12),
            const InstaCareStatusBadge(
              label: 'Active',
              type: InstaCareStatusBadgeType.active,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2) Skeleton Loading (Shimmer)

```dart
const InstaCareSkeletonLoading(
  width: double.infinity,
  height: 48,
  borderRadius: BorderRadius.all(Radius.circular(8)),
);
```

### 3) Booking Card (Data Comes From Parent)

`InstaCareBookingCard` is display-only. Keep state/content in your page and pass data in.

```dart
InstaCareBookingCard(
  category: 'Nursing',
  serviceName: 'Vitals Monitoring',
  patientName: 'Jimmy',
  bookingId: '0125',
  location: 'Anna Nagar',
  dateTime: 'Sep 08, 10.30 AM',
  durationText: 'Duration : 1h 30m', // optional
  status: InstaCareStatusBadgeType.inTravel,
);
```

### 4) Dialog

```dart
final confirmed = await showInstaCareConfirmationDialog(
  context: context,
  title: 'Are You Sure?',
  body: 'Do you want to continue?',
  confirmText: 'Remove',
  cancelText: 'Cancel',
);
```

## Theming Guidelines

Use shared tokens everywhere for consistency:

- Colors from `AppColors`
- Text styles from `InstaCareTypography`
- Button sizing from `ButtonSize`

Example:

```dart
Container(
  color: AppColors.ivory7,
  child: Text(
    'Instacare',
    style: InstaCareTypography.h2.copyWith(color: AppColors.primary2),
  ),
);
```

## Run Example Gallery

```bash
cd instacare_components/example
flutter run
```

Main gallery entry:
- `example/lib/main.dart`

## Development Notes

- This package is used as a Flutter UI library.
- Prefer adding new UI components under `lib/src/<group>/`.
- Export new public APIs through `lib/instacare_components.dart`.
- Keep color and typography usage aligned to `AppColors` and `InstaCareTypography`.

## License

See `LICENSE`.
