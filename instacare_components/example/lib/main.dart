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
        isPartner: isPartner,
        onRoleChanged: (value) => setState(() => isPartner = value),
      ),
    );
  }
}

class _BookingCardDemoState {
  final String category;
  final String serviceName;
  final String patientName;
  final String bookingId;
  final String location;
  final String dateTime;
  final String? durationText;
  final InstaCareStatusBadgeType status;

  const _BookingCardDemoState({
    required this.category,
    required this.serviceName,
    required this.patientName,
    required this.bookingId,
    required this.location,
    required this.dateTime,
    required this.status,
    this.durationText,
  });
}

class Gallery extends StatefulWidget {
  final bool isPartner;
  final ValueChanged<bool> onRoleChanged;

  const Gallery({
    super.key,
    required this.isPartner,
    required this.onRoleChanged,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late int _selectedRoleIndex;
  late final PageController _pageController;

  bool loading = false;
  String? selectedGender;
  String? selectedService;
  String? selectedMcq = 'Option 1';
  String otp = '';
  int rating = 3;
  int currentStepperStep = 0;
  int currentNavIndex = 0;
  int bookingCardStateIndex = 0;
  DateTime? selectedDate;
  bool checkOne = false;
  bool checkboxCard1 = false;
  bool checkboxCard2 = true;
  String selectedRadio = 'Yes';
  final Set<String> selectedFilters = <String>{'Wound Dressing'};
  Set<String> selectedMultiDropdown = <String>{'check box 2'};
  final List<_BookingCardDemoState> _bookingCardStates =
      const <_BookingCardDemoState>[
    _BookingCardDemoState(
      category: 'Nursing',
      serviceName: 'Vitals Monitoring',
      patientName: 'Jimmy',
      bookingId: '0125',
      location: 'Anna Nagar',
      dateTime: 'Sep 08, 10.30 AM',
      status: InstaCareStatusBadgeType.active,
    ),
    _BookingCardDemoState(
      category: 'Nursing',
      serviceName: 'Vitals Monitoring',
      patientName: 'Jimmy',
      bookingId: '0125',
      location: 'Anna Nagar',
      dateTime: 'Sep 08, 10.30 AM',
      durationText: 'Duration : 1h 30m',
      status: InstaCareStatusBadgeType.inTravel,
    ),
    _BookingCardDemoState(
      category: 'Nursing',
      serviceName: 'Vitals Monitoring',
      patientName: 'John Durai',
      bookingId: '0125',
      location: 'Anna Nagar',
      dateTime: 'Sep 08, 10.30 AM',
      status: InstaCareStatusBadgeType.upcoming,
    ),
    _BookingCardDemoState(
      category: 'Nursing',
      serviceName: 'Vitals Monitoring',
      patientName: 'Jimmy',
      bookingId: '0125',
      location: 'Anna Nagar',
      dateTime: 'Sep 08, 10.30 AM',
      durationText: 'Duration : 1h 30m',
      status: InstaCareStatusBadgeType.completed,
    ),
    _BookingCardDemoState(
      category: 'Nursing',
      serviceName: 'Vitals Monitoring',
      patientName: 'Jimmy',
      bookingId: '0125',
      location: 'Anna Nagar',
      dateTime: 'Sep 08, 10.30 AM',
      status: InstaCareStatusBadgeType.cancelled,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedRoleIndex = widget.isPartner ? 0 : 1;
    _pageController = PageController(initialPage: _selectedRoleIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectRole(int index) {
    if (_selectedRoleIndex == index) return;

    setState(() => _selectedRoleIndex = index);
    widget.onRoleChanged(index == 0);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  Widget _roleSlider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final segmentWidth = constraints.maxWidth / 3;
        return Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.baseWhite,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.primary8),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                left: _selectedRoleIndex * segmentWidth,
                top: 4,
                bottom: 4,
                width: segmentWidth,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Row(
                children: [
                  _roleItem('Partner', 0),
                  _roleItem('Patient', 1),
                  _roleItem('Common', 2),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _roleItem(String label, int index) {
    final active = _selectedRoleIndex == index;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => _selectRole(index),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: active ? AppColors.baseWhite : AppColors.gray3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeading(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.gray2,
        ),
      ),
    );
  }

  Widget _bookingStateControl() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_bookingCardStates.length, (index) {
          final isSelected = bookingCardStateIndex == index;
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => setState(() => bookingCardStateIndex = index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                '${index + 1}',
                style: InstaCareTypography.m.copyWith(
                  color: isSelected ? AppColors.primary2 : AppColors.gray4,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _componentBlock({
    required String title,
    required String fileName,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.ivory7,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary9, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.gray2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            fileName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gray5,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _skeletonPagePreview() {
    return const Column(
      children: [
        InstaCareSkeletonLoading(
          width: double.infinity,
          height: 18,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        SizedBox(height: 10),
        InstaCareSkeletonLoading(
          width: double.infinity,
          height: 12,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        SizedBox(height: 8),
        InstaCareSkeletonLoading(
          width: double.infinity,
          height: 12,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            InstaCareSkeletonLoading(
              width: 56,
              height: 56,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  InstaCareSkeletonLoading(
                    width: double.infinity,
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  SizedBox(height: 8),
                  InstaCareSkeletonLoading(
                    width: double.infinity,
                    height: 12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        InstaCareSkeletonLoading(
          width: double.infinity,
          height: 48,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ],
    );
  }

  Widget _bottomNavDemo() {
    return _componentBlock(
      title: 'Bottom App Nav Bar (Reference)',
      fileName: 'bottom_app_nav_bar.dart',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InstaCareBottomAppNavBar(
          currentIndex: currentNavIndex,
          onTap: (index) => setState(() => currentNavIndex = index),
          backgroundColor: AppColors.ivory7,
          selectedItemColor: AppColors.primary2,
          unselectedItemColor: AppColors.primary6,
          topBorderColor: AppColors.primary2,
          showShadow: true,
          items: const [
            InstaCareBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
            InstaCareBottomNavItem(
              icon: Icons.list_alt,
              label: 'Bookings',
            ),
            InstaCareBottomNavItem(
              icon: Icons.medical_services_outlined,
              label: 'Services',
            ),
            InstaCareBottomNavItem(
                icon: Icons.person_outline, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerPage() {
    final bookingState = _bookingCardStates[
        bookingCardStateIndex.clamp(0, _bookingCardStates.length - 1)];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        _sectionHeading('Partner Components'),
        _sectionHeading('Feedback'),
        _componentBlock(
          title: 'Message Box',
          fileName: 'message_box.dart',
          child: const Column(
            children: [
              InstaCareMessageBox(
                  type: InstaCareMessageType.info,
                  title: 'Info message box',
                  body: 'Body text goes here'),
              SizedBox(height: 8),
              InstaCareMessageBox(
                  type: InstaCareMessageType.error,
                  title: 'Error message box',
                  body: 'Body text goes here'),
              SizedBox(height: 8),
              InstaCareMessageBox(
                  type: InstaCareMessageType.pending,
                  title: 'Pending message box',
                  body: 'Body text goes here'),
              SizedBox(height: 8),
              InstaCareMessageBox(
                  type: InstaCareMessageType.success,
                  title: 'Success message box',
                  body: 'Body text goes here'),
            ],
          ),
        ),
        _componentBlock(
          title: 'Progress Bar',
          fileName: 'progress_bar.dart',
          child: const InstaCareProgressBar(value: 0.65, label: 'Progress bar'),
        ),
        _sectionHeading('Cards'),
        _componentBlock(
          title: 'Booking Card',
          fileName: 'booking_card.dart',
          child: InstaCareBookingCard(
            category: bookingState.category,
            serviceName: bookingState.serviceName,
            patientName: bookingState.patientName,
            bookingId: bookingState.bookingId,
            location: bookingState.location,
            dateTime: bookingState.dateTime,
            durationText: bookingState.durationText,
            status: bookingState.status,
            backgroundColor: AppColors.ivory7,
            bookingIdPrefix: 'Booking ID:',
            inTravelStatusLabel: 'In-Travel',
            fallbackPatientInitial: 'P',
            categoryServiceSeparator: ' - ',
          ),
        ),
        _bookingStateControl(),
        _componentBlock(
          title: 'Income Tile',
          fileName: 'income_tile.dart',
          child: InstaCareIncomeTile(
            title: "This month's earnings",
            amount: 'Rs 0',
            redeemButtonText: 'Redeem',
            onRedeem: () {},
            backgroundColor: AppColors.ivory7,
          ),
        ),
        _componentBlock(
          title: 'Card List View',
          fileName: 'card_list_view.dart',
          child: const InstaCareCardListView(
            items: [
              InstaCareCardListItem(
                card: InstaCareCard(
                  backgroundColor: AppColors.ivory7,
                  child: Center(child: Text('Card')),
                ),
                title: 'Wound Dressing',
                body: 'Daily care service with dressing change.',
              ),
              InstaCareCardListItem(
                card: InstaCareCard(
                  backgroundColor: AppColors.ivory7,
                  child: Center(child: Text('Card')),
                ),
                title: 'Nursing Visit',
                body: 'Vitals check and medication support.',
              ),
            ],
          ),
        ),
        _sectionHeading('Badges'),
        _componentBlock(
          title: 'Appointment Status Pills',
          fileName: 'appointment_status_pills.dart',
          child: const InstaCareAppointmentStatusPills(),
        ),
        _sectionHeading('Pills'),
        _componentBlock(
          title: 'Hours Summary Pill',
          fileName: 'hours_summary_pill.dart',
          child:
              const InstaCareHoursSummaryPill(text: 'Selected hours: 04h 30m'),
        ),
        _sectionHeading('Steps'),
        _componentBlock(
          title: 'Horizontal Stepper',
          fileName: 'stepper.dart',
          child: InstaCareVerticalStepper(
            currentStep: currentStepperStep,
            onStepChanged: (step) => setState(() => currentStepperStep = step),
            items: const [
              InstaCareStepperItem(title: 'Step 1'),
              InstaCareStepperItem(title: 'Step 2'),
              InstaCareStepperItem(title: 'Step 3'),
            ],
          ),
        ),
        _sectionHeading('Upload'),
        _componentBlock(
          title: 'File Upload Tile',
          fileName: 'file_upload_tile.dart',
          child: InstaCareFileUploadTile(onTap: () {}),
        ),
        _sectionHeading('Navigation'),
        _bottomNavDemo(),
      ],
    );
  }

  Widget _buildPatientPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        _sectionHeading('Patient Components'),
        _componentBlock(
          title: 'No Components',
          fileName: 'partner_only',
          child: const Text(
            'not yet ready ...',
          ),
        ),
      ],
    );
  }

  Widget _buildCommonPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        _sectionHeading('Common Components'),
        _sectionHeading('Headings'),
        _componentBlock(
          title: 'Top Header Title',
          fileName: 'theme/heading.dart',
          child: InstaCareHeading.topHeaderTitle('Top Header Title'),
        ),
        _componentBlock(
          title: 'Title with Back Button',
          fileName: 'theme/heading.dart',
          child: InstaCareHeading.titleWithBackButton(
            text: 'Title',
            onBackPressed: () {},
          ),
        ),
        _sectionHeading('Animation'),
        _componentBlock(
          title: 'Skeleton Loading',
          fileName: 'animation/skeleton_loading.dart',
          child: _skeletonPagePreview(),
        ),
        _componentBlock(
          title: 'Carousel',
          fileName: 'animation/carousel.dart',
          child: InstaCareCarousel(
            height: 160,
            items: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary9,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ivory3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray6.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Card 1',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray2,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.ivory7,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ivory3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray6.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Card 2',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray2,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary8,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ivory3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray6.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Card 3',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _sectionHeading('Buttons'),
        _componentBlock(
          title: 'Button States',
          fileName: 'button.dart',
          child: Column(
            children: [
              InstaCareButton(
                  text: 'Primary Button', fullWidth: true, onPressed: () {}),
              const SizedBox(height: 10),
              InstaCareButton.secondary(
                  text: 'Secondary Button', fullWidth: true, onPressed: () {}),
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
              const InstaCareButton(
                  text: 'Disabled',
                  fullWidth: true,
                  isDisabled: true,
                  onPressed: null),
            ],
          ),
        ),
        _sectionHeading('Inputs'),
        _componentBlock(
          title: 'Text Inputs',
          fileName: 'text_field.dart',
          child: const Column(
            children: [
              InstaCareTextField(
                label: 'Text Input',
                hint: 'placeholder',
                fillColor: AppColors.ivory7,
                borderColor: AppColors.primary3,
                focusedBorderColor: AppColors.primary2,
                hintColor: AppColors.gray2,
              ),
              SizedBox(height: 12),
              InstaCareTextField(
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email_outlined,
              ),
            ],
          ),
        ),
        _componentBlock(
          title: 'Phone Input',
          fileName: 'phone_input.dart',
          child: const InstaCarePhoneInput(
            label: 'Mobile Number With Region Selector',
            hint: '87921 34521',
          ),
        ),
        _componentBlock(
          title: 'Dropdown',
          fileName: 'dropdown.dart',
          child: InstaCareDropdown<String>(
            label: 'Gender',
            hint: 'Select gender',
            value: selectedGender,
            items: const ['Male', 'Female', 'Other'],
            onChanged: (value) => setState(() => selectedGender = value),
          ),
        ),
        _componentBlock(
          title: 'Dropdown With Checkbox',
          fileName: 'dropdown_with_checkbox.dart',
          child: InstaCareDropdownWithCheckbox<String>(
            label: 'Drop Down With Check Box',
            hint: 'Select options',
            items: const ['check box 1', 'check box 2', 'check box 3'],
            selectedItems: selectedMultiDropdown,
            onChanged: (next) => setState(() => selectedMultiDropdown = next),
          ),
        ),
        _componentBlock(
          title: 'Date Picker',
          fileName: 'date_picker_field.dart',
          child: InstaCareDatePickerField(
            label: 'Date Picker',
            value: selectedDate,
            onChanged: (next) => setState(() => selectedDate = next),
          ),
        ),
        _componentBlock(
          title: 'Search Bar',
          fileName: 'search_bar.dart',
          child: const InstaCareSearchBar(hint: 'Search services'),
        ),
        _componentBlock(
          title: 'Checkbox',
          fileName: 'checkbox_field.dart',
          child: InstaCareCheckboxField(
            value: checkOne,
            onChanged: (checked) => setState(() => checkOne = checked ?? false),
            label: 'Checkbox 1',
          ),
        ),
        _componentBlock(
          title: 'OTP Input',
          fileName: 'otp_input.dart',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InstaCareOtpInput(
                length: 6,
                onChanged: (value) => setState(() => otp = value),
                onCompleted: (value) => setState(() => otp = value),
              ),
              if (otp.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Entered OTP: $otp'),
              ],
            ],
          ),
        ),
        _sectionHeading('Selection'),
        _componentBlock(
          title: 'Radio Buttons',
          fileName: 'radio_buttons.dart',
          child: InstaCareRadioButtons<String>(
            groupValue: selectedRadio,
            options: const [
              InstaCareRadioOption(value: 'Yes', label: 'Yes'),
              InstaCareRadioOption(value: 'No', label: 'No'),
            ],
            onChanged: (value) =>
                setState(() => selectedRadio = value ?? 'Yes'),
            direction: Axis.horizontal,
          ),
        ),
        _componentBlock(
          title: 'MCQ Option Selector',
          fileName: 'mcq_option_selector.dart',
          child: InstaCareMcqOptionSelector(
            question: 'Question',
            options: const ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
            selected: selectedMcq,
            onSelected: (value) => setState(() => selectedMcq = value),
            previousLabel: 'Previous Question',
            nextLabel: 'Next Question',
            onPrevious: () {},
            onNext: () {},
          ),
        ),
        _componentBlock(
          title: 'Service Pills',
          fileName: 'service_pills.dart',
          child: InstaCareServicePills(
            services: const ['Minor', 'Major', 'Nursing'],
            selected: selectedService,
            onSelected: (value) => setState(() => selectedService = value),
          ),
        ),
        _componentBlock(
          title: 'Filter Pills',
          fileName: 'filter_pills.dart',
          child: InstaCareFilterPills(
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
        ),
        _componentBlock(
          title: 'Rating Scale',
          fileName: 'rating_scale.dart',
          child: InstaCareRatingScale(
            currentRating: rating,
            onRatingChanged: (value) => setState(() => rating = value),
          ),
        ),
        _sectionHeading('Dialogs'),
        _componentBlock(
          title: 'Confirmation Dialog',
          fileName: 'confirmation_dialog.dart',
          child: InstaCareButton.secondary(
            text: 'Pop confirmation',
            onPressed: () async {
              final confirmed = await showInstaCareConfirmationDialog(
                context: context,
                title: 'Confirmation',
                body: 'Do you want to continue?',
              );
              if (!mounted) return;
              if (confirmed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Confirmed')));
              }
            },
          ),
        ),
        _sectionHeading('Cards'),
        _componentBlock(
          title: 'Checkbox Card',
          fileName: 'checkbox_card.dart',
          child: Column(
            children: [
              InstaCareCheckboxCard(
                title: 'Card Title 1',
                message: 'This is a small message text that describes the card content.',
                isSelected: checkboxCard1,
                onChanged: (value) => setState(() => checkboxCard1 = value),
              ),
              const SizedBox(height: 12),
              InstaCareCheckboxCard(
                title: 'Card Title 2',
                message: 'Another card with a different message for demonstration.',
                isSelected: checkboxCard2,
                onChanged: (value) => setState(() => checkboxCard2 = value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instacare Components'),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.ivory7,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.baseWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: _roleSlider(),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (_selectedRoleIndex != index) {
                      setState(() => _selectedRoleIndex = index);
                      widget.onRoleChanged(index == 0);
                    }
                  },
                  children: [
                    _buildPartnerPage(),
                    _buildPatientPage(),
                    _buildCommonPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
