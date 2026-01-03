#!/bin/bash

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║        🏥 INSTACARE COMPONENTS - PERFECT VERSION 🏥           ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

if [ -d "instacare_components" ]; then
  rm -rf instacare_components
fi

echo "📁 Creating plugin..."
flutter create --template=plugin --platforms=android,ios,web,macos instacare_components

cd instacare_components

echo "⚙️  Fixing files..."

# Find and fix Android plugin
ANDROID_PLUGIN=$(find android -name "*Plugin.kt" -o -name "*Plugin.java" 2>/dev/null | head -1)
if [ -n "$ANDROID_PLUGIN" ]; then
  if [[ $ANDROID_PLUGIN == *.kt ]]; then
    cat > "$ANDROID_PLUGIN" << 'EOF'
package com.example.instacare_components

import io.flutter.embedding.engine.plugins.FlutterPlugin

class InstacareComponentsPlugin: FlutterPlugin {
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {}
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}
EOF
  else
    cat > "$ANDROID_PLUGIN" << 'EOF'
package com.example.instacare_components;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
public class InstacareComponentsPlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {}
  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {}
}
EOF
  fi
fi

# DELETE the problematic platform interface file
rm -f lib/instacare_components_platform_interface.dart
rm -f lib/instacare_components_method_channel.dart

# Update pubspec.yaml
cat > pubspec.yaml << 'EOF'
name: instacare_components
description: UI component library
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.16.0"
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
flutter:
  plugin:
    platforms:
      android:
        package: com.example.instacare_components
        pluginClass: InstacareComponentsPlugin
      ios:
        pluginClass: InstacareComponentsPlugin
      macos:
        pluginClass: InstacareComponentsPlugin
EOF

echo "📚 Creating components..."

mkdir -p lib/src/{buttons,inputs,cards,types}

cat > lib/instacare_components.dart << 'EOF'
library instacare_components;
export 'src/buttons/ic_button.dart';
export 'src/inputs/ic_text_field.dart';
export 'src/cards/ic_card.dart';
export 'src/cards/ic_info_card.dart';
export 'src/types/button_size.dart';
EOF

cat > lib/src/types/button_size.dart << 'EOF'
import 'package:flutter/material.dart';
enum ButtonSize { small, medium, large }
extension ButtonSizeExtension on ButtonSize {
  double get height => switch (this) { ButtonSize.small => 36, ButtonSize.medium => 48, ButtonSize.large => 56 };
  EdgeInsets get padding => switch (this) {
    ButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ButtonSize.large => const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
  };
}
EOF

cat > lib/src/buttons/ic_button.dart << 'EOF'
import 'package:flutter/material.dart';
import '../types/button_size.dart';

class ICButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize size;
  final IconData? icon;
  final bool fullWidth;
  final _ButtonVariant _variant;

  const ICButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.size = ButtonSize.medium, this.icon, this.fullWidth = false}) : _variant = _ButtonVariant.primary;
  const ICButton.secondary({super.key, required this.text, this.onPressed, this.isLoading = false, this.size = ButtonSize.medium, this.icon, this.fullWidth = false}) : _variant = _ButtonVariant.secondary;
  const ICButton.text({super.key, required this.text, this.onPressed, this.isLoading = false, this.size = ButtonSize.medium, this.icon, this.fullWidth = false}) : _variant = _ButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget child = isLoading
        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(_variant == _ButtonVariant.primary ? theme.colorScheme.onPrimary : theme.colorScheme.primary)))
        : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)], Text(text)]);
    return SizedBox(height: size.height, width: fullWidth ? double.infinity : null, child: _buildButton(context, child));
  }

  Widget _buildButton(BuildContext context, Widget child) => switch (_variant) {
    _ButtonVariant.primary => ElevatedButton(onPressed: isLoading ? null : onPressed, style: ElevatedButton.styleFrom(padding: size.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: child),
    _ButtonVariant.secondary => OutlinedButton(onPressed: isLoading ? null : onPressed, style: OutlinedButton.styleFrom(padding: size.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: child),
    _ButtonVariant.text => TextButton(onPressed: isLoading ? null : onPressed, style: TextButton.styleFrom(padding: size.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: child),
  };
}

enum _ButtonVariant { primary, secondary, text }
EOF

cat > lib/src/inputs/ic_text_field.dart << 'EOF'
import 'package:flutter/material.dart';

class ICTextField extends StatefulWidget {
  final String? label, hint;
  final TextEditingController? controller;
  final bool obscureText, enabled, showPasswordToggle;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  const ICTextField({super.key, this.label, this.hint, this.controller, this.obscureText = false, this.keyboardType, this.prefixIcon, this.onChanged, this.maxLines = 1, this.enabled = true, this.showPasswordToggle = false});
  const ICTextField.password({super.key, this.label, this.hint, this.controller, this.onChanged, this.enabled = true}) : obscureText = true, keyboardType = null, prefixIcon = Icons.lock_outline, maxLines = 1, showPasswordToggle = true;

  @override
  State<ICTextField> createState() => _ICTextFieldState();
}

class _ICTextFieldState extends State<ICTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      if (widget.label != null) ...[Text(widget.label!, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)), const SizedBox(height: 8)],
      TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        maxLines: _obscureText ? 1 : widget.maxLines,
        enabled: widget.enabled,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.showPasswordToggle && widget.obscureText ? IconButton(icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => _obscureText = !_obscureText)) : null,
          counterText: '',
        ),
      ),
    ]);
  }
}
EOF

cat > lib/src/cards/ic_card.dart << 'EOF'
import 'package:flutter/material.dart';
class ICCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  const ICCard({super.key, required this.child, this.padding, this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Padding(padding: padding ?? const EdgeInsets.all(16), child: child)));
}
EOF

cat > lib/src/cards/ic_info_card.dart << 'EOF'
import 'package:flutter/material.dart';
class ICInfoCard extends StatelessWidget {
  final Widget? leading, trailing;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  const ICInfoCard({super.key, this.leading, required this.title, this.subtitle, this.trailing, this.onTap});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [if (leading != null) ...[leading!, const SizedBox(width: 12)], Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)), if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: theme.textTheme.bodyMedium)]])), if (trailing != null) ...[const SizedBox(width: 12), trailing!]]))));
  }
}
EOF

echo "🎨 Setting up example..."

cat > example/pubspec.yaml << 'EOF'
name: example
publish_to: none
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
  instacare_components:
    path: ../
flutter:
  uses-material-design: true
EOF

mkdir -p example/lib/themes

# FIXED CardTheme issue
cat > example/lib/themes/user_theme.dart << 'EOF'
import 'package:flutter/material.dart';

class UserTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: Color(0xFF2196F3), secondary: Color(0xFF00BCD4)),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF2196F3), foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF2196F3),
        side: const BorderSide(color: Color(0xFF2196F3), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
EOF

cat > example/lib/themes/partner_theme.dart << 'EOF'
import 'package:flutter/material.dart';

class PartnerTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: Color(0xFF9C27B0), secondary: Color(0xFFFF6F00)),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF9C27B0), foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9C27B0),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF9C27B0),
        side: const BorderSide(color: Color(0xFF9C27B0), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
EOF

cat > example/lib/main.dart << 'EOF'
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
EOF

cd ..

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ✅ PERFECT! ✅                              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Run:"
echo "   cd instacare_components/example"
echo "   flutter pub get"
echo "   flutter run"
echo ""