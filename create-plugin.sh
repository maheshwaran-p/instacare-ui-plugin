#!/bin/bash

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           🏥 INSTACARE UI PLUGIN - FROM FIGMA 🏥              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

if [ -d "instacare_components" ]; then
  rm -rf instacare_components
fi

echo "📁 Creating plugin..."
flutter create --template=plugin --platforms=android,ios,web,macos instacare_components

cd instacare_components

echo "⚙️  Fixing platform files..."

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
  fi
fi

rm -f lib/instacare_components_platform_interface.dart
rm -f lib/instacare_components_method_channel.dart

cat > pubspec.yaml << 'EOF'
name: instacare_components
description: Instacare UI component library
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

echo "📚 Creating components from Figma design..."

mkdir -p lib/src/{buttons,inputs,cards,types}

cat > lib/instacare_components.dart << 'EOF'
library instacare_components;
export 'src/buttons/ic_button.dart';
export 'src/inputs/ic_text_field.dart';
export 'src/inputs/ic_otp_input.dart';
export 'src/inputs/ic_dropdown.dart';
export 'src/inputs/ic_phone_input.dart';
export 'src/cards/ic_card.dart';
export 'src/types/button_size.dart';
EOF

cat > lib/src/types/button_size.dart << 'EOF'
import 'package:flutter/material.dart';
enum ButtonSize { small, medium, large }
extension ButtonSizeExtension on ButtonSize {
  double get height => switch (this) { 
    ButtonSize.small => 40, 
    ButtonSize.medium => 48, 
    ButtonSize.large => 56 
  };
  EdgeInsets get padding => switch (this) {
    ButtonSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ButtonSize.large => const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
  final bool isDisabled;

  const ICButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
    this.isDisabled = false,
  }) : _variant = _ButtonVariant.primary;

  const ICButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
    this.isDisabled = false,
  }) : _variant = _ButtonVariant.secondary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _variant == _ButtonVariant.primary 
                    ? Colors.white
                    : theme.colorScheme.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _variant == _ButtonVariant.primary 
                      ? Colors.white 
                      : theme.colorScheme.primary,
                ),
              ),
            ],
          );

    return SizedBox(
      height: size.height,
      width: fullWidth ? double.infinity : null,
      child: _buildButton(context, child),
    );
  }

  Widget _buildButton(BuildContext context, Widget child) {
    final theme = Theme.of(context);
    
    switch (_variant) {
      case _ButtonVariant.primary:
        return ElevatedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            padding: size.padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: child,
        );
      case _ButtonVariant.secondary:
        return OutlinedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            padding: size.padding,
            side: BorderSide(
              color: isDisabled 
                  ? Colors.grey.shade300 
                  : theme.colorScheme.primary,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: child,
        );
    }
  }
}

enum _ButtonVariant { primary, secondary }
EOF

cat > lib/src/inputs/ic_text_field.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ICTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final bool enabled;
  final bool showPasswordToggle;
  final String? errorText;
  final FormFieldValidator<String>? validator;

  const ICTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.showPasswordToggle = false,
    this.errorText,
    this.validator,
  });

  const ICTextField.password({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.errorText,
    this.validator,
  })  : obscureText = true,
        keyboardType = null,
        prefixIcon = Icons.lock_outline,
        suffixIcon = null,
        maxLines = 1,
        showPasswordToggle = true;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          validator: widget.validator,
          maxLines: _obscureText ? 1 : widget.maxLines,
          enabled: widget.enabled,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon, color: Colors.grey.shade600) 
                : null,
            suffixIcon: _buildSuffixIcon(),
            errorText: widget.errorText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showPasswordToggle && widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Colors.grey.shade600,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }
    return widget.suffixIcon;
  }
}
EOF

cat > lib/src/inputs/ic_otp_input.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ICOtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  const ICOtpInput({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<ICOtpInput> createState() => _ICOtpInputState();
}

class _ICOtpInputState extends State<ICOtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otpValue => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 56,
          height: 56,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < widget.length - 1) {
                _focusNodes[index + 1].requestFocus();
              }
              
              widget.onChanged?.call(_otpValue);
              
              if (_otpValue.length == widget.length) {
                widget.onCompleted?.call(_otpValue);
              }
            },
            onTap: () {
              _controllers[index].selection = TextSelection.fromPosition(
                TextPosition(offset: _controllers[index].text.length),
              );
            },
          ),
        );
      }),
    );
  }
}
EOF

cat > lib/src/inputs/ic_dropdown.dart << 'EOF'
import 'package:flutter/material.dart';

class ICDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemLabel;

  const ICDropdown({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(hint ?? 'Select'),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel?.call(item) ?? item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
EOF

cat > lib/src/inputs/ic_phone_input.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ICPhoneInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String countryCode;

  const ICPhoneInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.countryCode = '+91',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          onChanged: onChanged,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: hint ?? 'Enter phone number',
            prefixIcon: Container(
              width: 80,
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇮🇳', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    countryCode,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  Container(width: 1, height: 24, color: Colors.grey.shade300),
                ],
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
EOF

cat > lib/src/cards/ic_card.dart << 'EOF'
import 'package:flutter/material.dart';

class ICCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;

  const ICCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 0,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
EOF

echo "🎨 Setting up example with Partner colors..."

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

# PARTNER APP THEME (from your Figma - dark green)
cat > example/lib/themes/partner_theme.dart << 'EOF'
import 'package:flutter/material.dart';

class PartnerTheme {
  // Colors from your Figma design
  static const Color primaryGreen = Color(0xFF1B4332);      // Dark green from buttons
  static const Color lightBeige = Color(0xFFD4C5B9);       // Background beige
  static const Color darkText = Color(0xFF1A1A1A);         // Text color
  
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: lightBeige,
    colorScheme: ColorScheme.light(
      primary: primaryGreen,
      secondary: const Color(0xFF52796F),
      surface: Colors.white,
      error: const Color(0xFFD32F2F),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: darkText,
      elevation: 0,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
    ),
  );
}
EOF

# USER APP THEME (from your Figma - white/clean)
cat > example/lib/themes/user_theme.dart << 'EOF'
import 'package:flutter/material.dart';

class UserTheme {
  static const Color primaryColor = Color(0xFF1B4332);     // Same green for consistency
  static const Color backgroundColor = Colors.white;        // Clean white background
  
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xFF52796F),
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1A1A1A),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
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
EOF

cd ..

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              ✅ INSTACARE UI CREATED! ✅                       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "🎨 Colors from your Figma:"
echo "   Partner: Dark Green (#1B4332) + Beige (#D4C5B9)"
echo "   User: Dark Green (#1B4332) + White"
echo ""
echo "🚀 Run: cd instacare_components/example && flutter pub get && flutter run"
echo ""