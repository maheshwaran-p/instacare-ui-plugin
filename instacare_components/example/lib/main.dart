import 'package:flutter/material.dart';
import 'package:instacare_components/instacare_components.dart';
import 'themes/partner_theme.dart';
import 'themes/user_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPartner = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isPartner ? PartnerTheme.theme : UserTheme.theme,
      home: Gallery(
        onToggleTheme: () => setState(() => isPartner = !isPartner),
        themeName: isPartner ? 'Partner Theme' : 'User Theme',
      ),
    );
  }
}

class Gallery extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final String themeName;

  const Gallery({
    super.key,
    required this.onToggleTheme,
    required this.themeName,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool loading = false;
  String? selectedGender;
  String? selectedService;
  String? selectedMcq = 'Option 1';
  String otp = '';
  int rating = 3;
  int currentStepperStep = 0;
  DateTime? selectedDate;
  bool checkOne = false;
  String selectedRadio = 'Yes';
  final Set<String> selectedFilters = <String>{'Wound Dressing'};
  Set<String> selectedMultiDropdown = <String>{'check box 2'};

  Widget _folderHeading(String name) {
    return Text(
      '$name/',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  Widget _scriptHeading(String file) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      child: Text(
        file,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instacare Components'),
        actions: [
          Chip(label: Text(widget.themeName, style: const TextStyle(fontSize: 12))),
          IconButton(icon: const Icon(Icons.palette), onPressed: widget.onToggleTheme),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.primary3,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.ivory7,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
          _folderHeading('buttons'),
          const SizedBox(height: 12),
          _scriptHeading('button.dart'),
          InstaCareCard(
            backgroundColor: AppColors.ivory7,
            child: Column(
              children: [
                InstaCareButton(text: 'Primary Button', fullWidth: true, onPressed: () {}),
                const SizedBox(height: 10),
                InstaCareButton.secondary(text: 'Secondary Button', fullWidth: true, onPressed: () {}),
                const SizedBox(height: 10),
                InstaCareButton(
                  text: loading ? 'Loading...' : 'Load Data',
                  isLoading: loading,
                  fullWidth: true,
                  onPressed: () {
                    setState(() => loading = true);
                    Future.delayed(const Duration(seconds: 1), () {
                      if (mounted) {
                        setState(() => loading = false);
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                const InstaCareButton(text: 'Disabled', fullWidth: true, isDisabled: true, onPressed: null),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _folderHeading('inputs'),
          const SizedBox(height: 12),
          InstaCareCard(
            backgroundColor: AppColors.ivory7,
            child: Column(
              children: [
                _scriptHeading('text_field.dart'),
                const InstaCareTextField(label: 'Email', hint: 'Enter your email', prefixIcon: Icons.email_outlined),
                const SizedBox(height: 12),
                const InstaCareTextField.password(label: 'Password', hint: 'Enter password'),
                const SizedBox(height: 12),
                _scriptHeading('phone_input.dart'),
                const InstaCarePhoneInput(label: 'Mobile Number With Region Selector', hint: '87921 34521'),
                const SizedBox(height: 12),
                _scriptHeading('dropdown.dart'),
                InstaCareDropdown<String>(
                  label: 'Gender',
                  hint: 'Select gender',
                  value: selectedGender,
                  items: const ['Male', 'Female', 'Other'],
                  onChanged: (value) => setState(() => selectedGender = value),
                ),
                const SizedBox(height: 12),
                _scriptHeading('dropdown_with_checkbox.dart'),
                InstaCareDropdownWithCheckbox<String>(
                  label: 'Drop Down With Check Box',
                  items: const ['check box 1', 'check box 2', 'check box 3'],
                  selectedItems: selectedMultiDropdown,
                  onChanged: (next) => setState(() => selectedMultiDropdown = next),
                ),
                const SizedBox(height: 12),
                _scriptHeading('date_picker_field.dart'),
                InstaCareDatePickerField(
                  label: 'Date Picker',
                  value: selectedDate,
                  onChanged: (next) => setState(() => selectedDate = next),
                ),
                const SizedBox(height: 12),
                _scriptHeading('search_bar.dart'),
                InstaCareSearchBar(hint: 'Search services'),
                const SizedBox(height: 12),
                _scriptHeading('checkbox_field.dart'),
                InstaCareCheckboxField(
                  value: checkOne,
                  onChanged: (checked) => setState(() => checkOne = checked ?? false),
                  label: 'Checkbox 1',
                ),
                const SizedBox(height: 12),
                _scriptHeading('otp_input.dart'),
                InstaCareOtpInput(
                  length: 4,
                  onCompleted: (value) => setState(() => otp = value),
                ),
                if (otp.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Entered OTP: $otp'),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          _folderHeading('selection'),
          const SizedBox(height: 12),
          InstaCareCard(
            backgroundColor: AppColors.ivory7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _scriptHeading('radio_buttons.dart'),
                InstaCareRadioButtons<String>(
                  groupValue: selectedRadio,
                  options: const [
                    InstaCareRadioOption(value: 'Yes', label: 'Yes'),
                    InstaCareRadioOption(value: 'No', label: 'No'),
                  ],
                  onChanged: (value) => setState(() => selectedRadio = value ?? 'Yes'),
                  direction: Axis.horizontal,
                ),
                const SizedBox(height: 12),
                _scriptHeading('mcq_option_selector.dart'),
                InstaCareMcqOptionSelector(
                  question: 'Question',
                  options: const ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
                  selected: selectedMcq,
                  onSelected: (value) => setState(() => selectedMcq = value),
                  onPrevious: () {},
                  onNext: () {},
                ),
                const SizedBox(height: 12),
                _scriptHeading('service_pills.dart'),
                InstaCareServicePills(
                  services: const ['Minor', 'Major', 'Nursing'],
                  selected: selectedService,
                  onSelected: (value) => setState(() => selectedService = value),
                ),
                const SizedBox(height: 12),
                _scriptHeading('filter_pills.dart'),
                InstaCareFilterPills(
                  items: const ['Wound Dressing', 'Injection', 'Vitals'],
                  selected: selectedFilters,
                  onToggle: (item) {
                    setState(() {
                      if (selectedFilters.contains(item)) {
                        selectedFilters.remove(item);
                      } else {
                        selectedFilters.add(item);
                      }
                    });
                  },
                ),
                const SizedBox(height: 12),
                _scriptHeading('rating_scale.dart'),
                InstaCareRatingScale(currentRating: rating, onRatingChanged: (value) => setState(() => rating = value)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _folderHeading('feedback'),
          const SizedBox(height: 12),
          _scriptHeading('message_box.dart'),
          InstaCareCard(
            backgroundColor: AppColors.ivory7,
            child: Column(
              children: const [
                InstaCareMessageBox(type: InstaCareMessageType.info, title: 'Info message box', body: 'Body text goes here'),
                SizedBox(height: 8),
                InstaCareMessageBox(type: InstaCareMessageType.error, title: 'Error message box', body: 'Body text goes here'),
                SizedBox(height: 8),
                InstaCareMessageBox(type: InstaCareMessageType.pending, title: 'Pending message box', body: 'Body text goes here'),
                SizedBox(height: 8),
                InstaCareMessageBox(type: InstaCareMessageType.success, title: 'Success message box', body: 'Body text goes here'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _scriptHeading('progress_bar.dart'),
          const InstaCareProgressBar(value: 1.0, label: 'Progress bar'),
          const SizedBox(height: 24),
          _folderHeading('cards'),
          const SizedBox(height: 12),
          _scriptHeading('booking_card.dart'),
          const InstaCareBookingCard(
            category: 'Category',
            serviceName: 'Service Name',
            patientName: 'Patient Name',
            bookingId: '1001',
            location: 'Location Name',
            dateTime: '00:00 AM - 00:00 AM',
            backgroundColor: AppColors.ivory7,
          ),
          const SizedBox(height: 12),
          _scriptHeading('income_tile.dart'),
          InstaCareIncomeTile(
            title: "This month's earnings",
            amount: 'Rs 0',
            onRedeem: () {},
            backgroundColor: AppColors.ivory7,
          ),
          const SizedBox(height: 12),
          _scriptHeading('card_grid_view.dart'),
          InstaCareCardGridView(
            children: const [
              InstaCareCard(backgroundColor: AppColors.ivory7, child: Center(child: Text('Card 1'))),
              InstaCareCard(backgroundColor: AppColors.ivory7, child: Center(child: Text('Card 2'))),
              InstaCareCard(backgroundColor: AppColors.ivory7, child: Center(child: Text('Card 3'))),
              InstaCareCard(backgroundColor: AppColors.ivory7, child: Center(child: Text('Card 4'))),
            ],
          ),
          const SizedBox(height: 24),
          _folderHeading('badges'),
          const SizedBox(height: 12),
          _scriptHeading('status_badge.dart'),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              InstaCareStatusBadge(label: 'active', type: InstaCareStatusBadgeType.active),
              InstaCareStatusBadge(label: 'upcoming', type: InstaCareStatusBadgeType.upcoming),
              InstaCareStatusBadge(label: 'cancelled', type: InstaCareStatusBadgeType.cancelled),
            ],
          ),
          const SizedBox(height: 24),
          _folderHeading('pills'),
          const SizedBox(height: 12),
          _scriptHeading('hours_summary_pill.dart'),
          const InstaCareHoursSummaryPill(text: 'Selected hours: 04h 30m'),
          const SizedBox(height: 12),
          _folderHeading('steps'),
          const SizedBox(height: 12),
          _scriptHeading('stepper.dart'),
          InstaCareVerticalStepper(
            currentStep: currentStepperStep,
            onStepChanged: (step) => setState(() => currentStepperStep = step),
            items: const [
              InstaCareStepperItem(title: 'Step 1'),
              InstaCareStepperItem(title: 'Step 2'),
              InstaCareStepperItem(title: 'Step 3'),
            ],
          ),
          const SizedBox(height: 24),
          _folderHeading('upload'),
          const SizedBox(height: 12),
          _scriptHeading('file_upload_tile.dart'),
          InstaCareFileUploadTile(onTap: () {}),
          const SizedBox(height: 24),
          _folderHeading('dialogs'),
          const SizedBox(height: 12),
          _scriptHeading('confirmation_dialog.dart'),
          InstaCareButton.secondary(
            text: 'Pop confirmation',
            onPressed: () async {
              final confirmed = await showInstaCareConfirmationDialog(
                context: context,
                title: 'Confirmation',
                body: 'Do you want to continue?',
              );
              if (confirmed && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confirmed')));
              }
            },
          ),
          const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
