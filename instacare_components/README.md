# Instacare Components

A Flutter UI component library for Instacare apps.

This package exposes reusable widgets for forms, selection controls, cards, feedback, navigation, steps, upload, and dialogs.

## What This Plugin Contains

- `buttons`: `InstaCareButton`, `InstaCareButton.secondary`
- `inputs`: `InstaCareTextField`, `InstaCareOtpInput`, `InstaCarePhoneInput`, `InstaCareDropdown`, `InstaCareDropdownWithCheckbox`, `InstaCareDatePickerField`, `InstaCareCheckboxField`, `InstaCareSearchBar`
- `selection`: `InstaCareRadioButtons`, `InstaCareMcqOptionSelector`, `InstaCareServicePills`, `InstaCareFilterPills`, `InstaCareRatingScale`
- `cards`: `InstaCareCard`, `InstaCareServiceCard`, `InstaCareBookingCard`, `InstaCareIncomeTile`, `InstaCareCardListView`
- `feedback`: `InstaCareMessageBox`, `InstaCareProgressBar`
- `navigation`: `InstaCareTopHeaderTitle`, `InstaCareBottomAppNavBar`
- `badges/pills/steps/upload`: `InstaCareStatusBadge`, `InstaCareHoursSummaryPill`, `InstaCareVerticalStepper`, `InstaCareFileUploadTile`
- `dialogs`: `showInstaCareConfirmationDialog(...)`
- `theme`: `AppColors`, `InstaCareTypography`, `ButtonSize`

## Install

Add dependency in your app `pubspec.yaml`.

```yaml
dependencies:
  instacare_components:
    path: ../instacare_components
```

Then run:

```bash
flutter pub get
```

## Import

```dart
import 'package:instacare_components/instacare_components.dart';
```

## Quick Start

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
          children: [
            InstaCareButton(text: 'Continue', onPressed: () {}),
            const SizedBox(height: 12),
            const InstaCareTextField(label: 'Email', hint: 'Enter your email'),
            const SizedBox(height: 12),
            const InstaCareStatusBadge(label: 'active', type: InstaCareStatusBadgeType.active),
          ],
        ),
      ),
    );
  }
}
```

## How To Call and Use Components

### Buttons

```dart
InstaCareButton(
  text: 'Primary',
  onPressed: () {},
  size: ButtonSize.medium,
  fullWidth: true,
);

InstaCareButton.secondary(
  text: 'Secondary',
  onPressed: () {},
);
```

Required params:
- `text`
- `onPressed` is optional, but if null the button is disabled.

### Inputs

```dart
final emailController = TextEditingController();
String? gender;
DateTime? selectedDate;
Set<String> selectedItems = {'B'};

Column(
  children: [
    InstaCareTextField(
      label: 'Email',
      hint: 'Enter your email',
      controller: emailController,
      onChanged: (v) {},
    ),
    const SizedBox(height: 10),
    const InstaCareTextField.password(label: 'Password', hint: 'Enter password'),
    const SizedBox(height: 10),
    InstaCareDropdown<String>(
      label: 'Gender',
      items: const ['Male', 'Female', 'Other'],
      value: gender,
      onChanged: (v) => gender = v,
    ),
    const SizedBox(height: 10),
    InstaCareDropdownWithCheckbox<String>(
      label: 'Skills',
      items: const ['A', 'B', 'C'],
      selectedItems: selectedItems,
      onChanged: (next) => selectedItems = next,
    ),
    const SizedBox(height: 10),
    InstaCareDatePickerField(
      label: 'Date',
      value: selectedDate,
      onChanged: (d) => selectedDate = d,
    ),
    const SizedBox(height: 10),
    const InstaCarePhoneInput(label: 'Phone', hint: '98765 43210'),
    const SizedBox(height: 10),
    const InstaCareSearchBar(hint: 'Search service'),
    const SizedBox(height: 10),
    InstaCareCheckboxField(
      value: true,
      onChanged: (v) {},
      label: 'Accept terms',
    ),
    const SizedBox(height: 10),
    InstaCareOtpInput(
      length: 4,
      onCompleted: (otp) {},
    ),
  ],
);
```

### Selection

```dart
String selectedRadio = 'Yes';
String? selectedService;
Set<String> selectedFilters = {'Injection'};
int rating = 3;

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    InstaCareRadioButtons<String>(
      groupValue: selectedRadio,
      options: const [
        InstaCareRadioOption(value: 'Yes', label: 'Yes'),
        InstaCareRadioOption(value: 'No', label: 'No'),
      ],
      onChanged: (v) => selectedRadio = v ?? 'Yes',
      direction: Axis.horizontal,
    ),
    InstaCareMcqOptionSelector(
      question: 'Question',
      options: const ['Option 1', 'Option 2'],
      selected: 'Option 1',
      onSelected: (v) {},
    ),
    InstaCareServicePills(
      services: const ['Minor', 'Major'],
      selected: selectedService,
      onSelected: (v) => selectedService = v,
    ),
    InstaCareFilterPills(
      items: const ['Injection', 'Vitals'],
      selected: selectedFilters,
      onToggle: (item) {},
    ),
    InstaCareRatingScale(
      currentRating: rating,
      onRatingChanged: (v) => rating = v,
    ),
  ],
);
```

### Cards

```dart
const InstaCareBookingCard(
  category: 'Nursing',
  serviceName: 'Wound Dressing',
  patientName: 'Rahul',
  bookingId: '1001',
  location: 'HSR Layout',
  dateTime: '10:00 AM - 11:00 AM',
);

InstaCareIncomeTile(
  title: "This month's earnings",
  amount: 'Rs 12,500',
  onRedeem: () {},
);

InstaCareCardListView(
  items: const [
    InstaCareCardListItem(
      card: InstaCareCard(child: Text('A')),
      title: 'Service A',
      body: 'Description for service A.',
    ),
    InstaCareCardListItem(
      card: InstaCareCard(child: Text('B')),
      title: 'Service B',
      body: 'Description for service B.',
    ),
  ],
);

InstaCareServiceCard(
  title: 'Nursing',
  subtitle: 'Compassionate care',
  priceText: 'from Rs499',
);
```

### Feedback

```dart
const InstaCareMessageBox(
  type: InstaCareMessageType.info,
  title: 'Info',
  body: 'Your profile is under review.',
);

const InstaCareProgressBar(
  value: 0.65,
  label: 'Profile completion',
);
```

### Navigation

```dart
Scaffold(
  appBar: InstaCareTopHeaderTitle(
    title: 'Home',
    onBack: () => Navigator.pop(context),
  ),
  bottomNavigationBar: InstaCareBottomAppNavBar(
    currentIndex: 0,
    onTap: (index) {},
    items: const [
      InstaCareBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
      InstaCareBottomNavItem(icon: Icons.calendar_month_outlined, label: 'Bookings'),
    ],
  ),
);
```

### Badges, Pills, Steps, Upload

```dart
const InstaCareStatusBadge(
  label: 'upcoming',
  type: InstaCareStatusBadgeType.upcoming,
);

const InstaCareHoursSummaryPill(text: 'Selected hours: 04h 30m');

InstaCareVerticalStepper(
  currentStep: 1,
  onStepChanged: (step) {},
  items: const [
    InstaCareStepperItem(title: 'Step 1'),
    InstaCareStepperItem(title: 'Step 2'),
    InstaCareStepperItem(title: 'Step 3'),
  ],
);

InstaCareFileUploadTile(onTap: () {});
```

### Dialog

```dart
final confirmed = await showInstaCareConfirmationDialog(
  context: context,
  title: 'Confirmation',
  body: 'Do you want to continue?',
  confirmText: 'Yes',
  cancelText: 'No',
);
```

## Theming and Design Tokens

Use exported tokens to keep styling consistent:

```dart
Container(
  color: AppColors.ivory7,
  child: Text(
    'Instacare',
    style: InstaCareTypography.h2.copyWith(color: AppColors.primary3),
  ),
);
```

`ButtonSize` options:
- `ButtonSize.small`
- `ButtonSize.medium`
- `ButtonSize.large`

## Example App

A full usage gallery is available in:
- `example/lib/main.dart`

Run it:

```bash
cd example
flutter run
```

## Notes

- The package is primarily a UI library. There are no method-channel APIs you need to call directly.
- Platform plugin scaffolding exists for Android, iOS, and macOS, but day-to-day usage is through exported Flutter widgets.
