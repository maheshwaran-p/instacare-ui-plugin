import 'package:flutter/material.dart';
import 'package:instacare_components/instacare_components.dart';
import 'themes/user_theme.dart';
import 'themes/partner_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPartner = true;  // Start with Partner theme
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: isPartner ? PartnerTheme.theme : UserTheme.theme,
    home: Gallery(
      onToggle: () => setState(() => isPartner = !isPartner),
      name: isPartner ? '💼 Partner (Green/Beige)' : '👤 User (White/Green)',
    ),
  );
}

class Gallery extends StatefulWidget {
  final VoidCallback onToggle;
  final String name;
  const Gallery({super.key, required this.onToggle, required this.name});
  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool loading = false;
  String otp = '';
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instacare Components'),
        actions: [
          Chip(label: Text(widget.name, style: const TextStyle(fontSize: 12))),
          IconButton(icon: const Icon(Icons.palette), onPressed: widget.onToggle),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ICCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theme-Aware Components', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Click palette to switch:\n• Partner: Dark green + Beige\n• User: Dark green + White', style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text('BUTTONS', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ICCard(
            child: Column(
              children: [
                ICButton(text: 'Primary Button', fullWidth: true, onPressed: () {}),
                const SizedBox(height: 12),
                ICButton.secondary(text: 'Secondary Button', fullWidth: true, onPressed: () {}),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: ICButton(text: 'Small', size: ButtonSize.small, onPressed: () {})),
                    const SizedBox(width: 8),
                    Expanded(child: ICButton(text: 'Medium', size: ButtonSize.medium, onPressed: () {})),
                    const SizedBox(width: 8),
                    Expanded(child: ICButton(text: 'Large', size: ButtonSize.large, onPressed: () {})),
                  ],
                ),
                const SizedBox(height: 12),
                ICButton(
                  text: loading ? 'Loading...' : 'Load Data',
                  isLoading: loading,
                  fullWidth: true,
                  onPressed: () {
                    setState(() => loading = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) setState(() => loading = false);
                    });
                  },
                ),
                const SizedBox(height: 12),
                const ICButton(text: 'Disabled', fullWidth: true, isDisabled: true, onPressed: null),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          Text('TEXT INPUTS', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ICCard(
            child: Column(
              children: [
                const ICTextField(label: 'Email', hint: 'Enter your email', prefixIcon: Icons.email_outlined),
                const SizedBox(height: 16),
                const ICTextField.password(label: 'Password', hint: 'Enter password'),
                const SizedBox(height: 16),
                const ICPhoneInput(label: 'Phone Number', hint: '98765 43210'),
                const SizedBox(height: 16),
                ICDropdown<String>(
                  label: 'Gender',
                  hint: 'Select gender',
                  value: selectedGender,
                  items: const ['Male', 'Female', 'Other'],
                  onChanged: (val) => setState(() => selectedGender = val),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          Text('OTP INPUT', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ICCard(
            child: Column(
              children: [
                const Text('Enter OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                ICOtpInput(
                  length: 4,
                  onCompleted: (val) => setState(() => otp = val),
                ),
                const SizedBox(height: 16),
                if (otp.isNotEmpty) Text('Entered OTP: $otp', style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          Text('CARDS', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ICCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. Smith', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text('Cardiologist', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
