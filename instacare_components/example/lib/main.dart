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
  bool isUser = true;
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: isUser ? UserTheme.theme : PartnerTheme.theme,
    home: Gallery(
      onToggle: () => setState(() => isUser = !isUser),
      name: isUser ? '👤 User (Blue)' : '💼 Partner (Purple)',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Components'),
        actions: [
          Chip(label: Text(widget.name)),
          IconButton(icon: const Icon(Icons.palette), onPressed: widget.onToggle),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ICCard(child: Text('Theme-aware components!\nClick palette to switch.')),
          const SizedBox(height: 20),
          Text('BUTTONS', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ICButton(text: 'Small', size: ButtonSize.small, onPressed: () {}),
              ICButton(text: 'Medium', onPressed: () {}),
              ICButton(text: 'Large', size: ButtonSize.large, onPressed: () {}),
              ICButton.secondary(text: 'Secondary', onPressed: () {}),
              ICButton.text(text: 'Text', onPressed: () {}),
              ICButton(
                text: loading ? 'Loading' : 'Load',
                isLoading: loading,
                onPressed: () {
                  setState(() => loading = true);
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) setState(() => loading = false);
                  });
                },
              ),
              ICButton(text: 'Icon', icon: Icons.check, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 12),
          ICButton(text: 'Full Width', fullWidth: true, onPressed: () {}),
          const SizedBox(height: 20),
          Text('TEXT FIELDS', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          const ICTextField(label: 'Email', hint: 'Enter email', prefixIcon: Icons.email),
          const SizedBox(height: 12),
          const ICTextField.password(label: 'Password'),
          const SizedBox(height: 12),
          const ICTextField(label: 'Phone', hint: '+91', prefixIcon: Icons.phone, keyboardType: TextInputType.phone),
          const SizedBox(height: 20),
          Text('CARDS', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          const ICInfoCard(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: 'Dr. Smith',
            subtitle: 'Cardiologist',
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
