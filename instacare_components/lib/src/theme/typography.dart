import 'package:flutter/material.dart';

class InstaCareTypography {
  InstaCareTypography._();

  /// -------------------------------
  /// FONT FAMILIES
  /// -------------------------------
  static const String headingFont = 'CrimsonPro';
  static const String bodyFont = 'Figtree';

  /// -------------------------------
  /// PAGE TITLE (h1)
  /// -------------------------------
  static const TextStyle h1 = TextStyle(
    fontFamily: headingFont,
    fontSize: 24,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    height: 1.25,
  );

  /// -------------------------------
  /// SECTION TITLE (h2)
  /// -------------------------------
  static const TextStyle h2 = TextStyle(
    fontFamily: headingFont,
    fontSize: 20,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    height: 1.3,
  );

  /// -------------------------------
  /// SECTION INNER TITLE (h3)
  /// -------------------------------
  static const TextStyle h3 = TextStyle(
    fontFamily: headingFont,
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    height: 1.35,
  );

  /// -------------------------------
  /// BODY TEXT (p)
  /// -------------------------------
  static const TextStyle body = TextStyle(
    fontFamily: bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0,
    height: 1.5,
  );

  /// -------------------------------
  /// ONE LINER - REGULAR (r)
  /// -------------------------------
  static const TextStyle r = TextStyle(
    fontFamily: bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0,
    height: 1.4,
  );

  /// -------------------------------
  /// ONE LINER - MEDIUM (m)
  /// -------------------------------
  static const TextStyle m = TextStyle(
    fontFamily: bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    height: 1.4,
  );

  /// -------------------------------
  /// SMALL - REGULAR (s)
  /// -------------------------------
  static const TextStyle s = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0,
    height: 1.4,
  );

  /// -------------------------------
  /// SMALL - MEDIUM (sm)
  /// -------------------------------
  static const TextStyle sm = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    height: 1.4,
  );

  /// -------------------------------
  /// EXTRA SMALL - MEDIUM (xs)
  /// -------------------------------
  static const TextStyle xs = TextStyle(
    fontFamily: bodyFont,
    fontSize: 10,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    height: 1.3,
  );
}
