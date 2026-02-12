import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // no instance

  /* =======================
   * Base Colors
   * ======================= */
  static const Color baseWhite = Color(0xFFFFFFFF);
  static const Color basePrimary = Color(0xFF34513A);
  static const Color baseSecondary = Color(0xFFDC9251);
  static const Color baseNatural = Color(0xFFA58E74);
  static const Color baseIvory = Color(0xFFFFEFCD);

  /* =======================
   * Primary Colors (1 → 10)
   * ======================= */
  static const Color primary1 = Color(0xFF001F02); // 900
  static const Color primary2 = Color(0xFF17381E); // 800
  static const Color primary3 = Color(0xFF34513A); // 700
  static const Color primary4 = Color(0xFF516A56); // 600
  static const Color primary5 = Color(0xFF6E8372); // 500
  static const Color primary6 = Color(0xFF8B9C8E); // 400
  static const Color primary7 = Color(0xFFA8B4AB); // 300
  static const Color primary8 = Color(0xFFC5CDC7); // 200
  static const Color primary9 = Color(0xFFE2E6E3); // 100
  static const Color primary10 = Color(0xFFF1F3F1); // 50

  /* =======================
   * Secondary Colors
   * ======================= */
  static const Color secondary1 = Color(0xFFD2731F); // 900
  static const Color secondary2 = Color(0xFFD78238); // 800
  static const Color secondary3 = Color(0xFFDC9251); // 700
  static const Color secondary4 = Color(0xFFE1A26A); // 600
  static const Color secondary5 = Color(0xFFE6B183); // 500
  static const Color secondary6 = Color(0xFFEBC19C); // 400
  static const Color secondary7 = Color(0xFFF0D0B4); // 300 //backgroundcolor
  static const Color secondary8 = Color(0xFFF5E0CD); // 200
  static const Color secondary9 = Color(0xFFFAEFE6); // 100
  static const Color secondary10 = Color(0xFFFDF7F3); // 50

  /* =======================
   * Natural Colors
   * ======================= */
  static const Color natural1 = Color(0xFF8B6E4C); // 900
  static const Color natural2 = Color(0xFF987E60); // 800
  static const Color natural3 = Color(0xFFA58E74); // 700
  static const Color natural4 = Color(0xFFB29E88); // 600
  static const Color natural5 = Color(0xFFBFAE9C); // 500
  static const Color natural6 = Color(0xFFCCBEB0); // 400
  static const Color natural7 = Color(0xFFD8CFC3); // 300
  static const Color natural8 = Color(0xFFE5DFD7); // 200
  static const Color natural9 = Color(0xFFF2EFEB); // 100
  static const Color natural10 = Color(0xFFF9F7F5); // 50

  /* =======================
   * Ivory (Warm) Colors
   * ======================= */
  static const Color ivory1 = Color(0xFFFFEABF); // 900
  static const Color ivory2 = Color(0xFFFFEDC6); // 800
  static const Color ivory3 = Color(0xFFFFEFCD); // 700
  static const Color ivory4 = Color(0xFFFFF1D4); // 600
  static const Color ivory5 = Color(0xFFFFF4DB); // 500
  static const Color ivory6 = Color(0xFFFFF6E2); // 400
  static const Color ivory7 = Color(0xFFFFF8EA); // 300
  static const Color ivory8 = Color(0xFFFFFAF1); // 200
  static const Color ivory9 = Color(0xFFFFFDF8); // 100
  static const Color ivory10 = Color(0xFFFFFEFB); // 50

  /* =======================
   * Gray Colors
   * ======================= */
  static const Color gray1 = Color(0xFF000000); // 900
  static const Color gray2 = Color(0xFF201F20); // 700
  static const Color gray3 = Color(0xFF403F40); // 600
  static const Color gray4 = Color(0xFF605F60); // 500
  static const Color gray5 = Color(0xFF807F80); // 400
  static const Color gray6 = Color(0xFF9F9F9F); // 300
  static const Color gray7 = Color(0xFFBFBFBF); // 200
  static const Color gray8 = Color(0xFFDFDFDF); // 100
  static const Color gray9 = Color(0xFFEFEFEF); // 50

  /* =======================
   * Error Colors
   * ======================= */
  static const Color error1 = Color(0xFFFB0000); // 900
  static const Color error2 = Color(0xFFFC0000); // 800
  static const Color error3 = Color(0xFFFC1C03); // 700
  static const Color error4 = Color(0xFFFC3C27); // 600
  static const Color error5 = Color(0xFFFD5D4B); // 500
  static const Color error6 = Color(0xFFFD7D6F); // 400
  static const Color error7 = Color(0xFFFE9E93); // 300
  static const Color error8 = Color(0xFFFEBEB7); // 200
  static const Color error9 = Color(0xFFFFDFDB); // 100
  static const Color error10 = Color(0xFFFFEFED); // 50

  /* =======================
   * Success Colors
   * ======================= */
  static const Color success1 = Color(0xFF00C400); // 900
  static const Color success2 = Color(0xFF15CA00); // 800
  static const Color success3 = Color(0xFF32D10A); // 700
  static const Color success4 = Color(0xFF4FD82D); // 600
  static const Color success5 = Color(0xFF6DDE50); // 500
  static const Color success6 = Color(0xFF8AE573); // 400
  static const Color success7 = Color(0xFFA7EB96); // 300
  static const Color success8 = Color(0xFFC4F2B9); // 200
  static const Color success9 = Color(0xFFE2F8DC); // 100
  static const Color success10 = Color(0xFFF0FCEE); // 50

  /* =======================
   * Semantic UI Colors
   * ======================= */
  static const Color infoBg = Color(0xFFEAF2FF);
  static const Color infoFg = Color(0xFF1D4ED8);
  static const Color warningBg = Color(0xFFFFF6E5);
  static const Color warningFg = Color(0xFF9A6700);
  static const Color errorBg = Color(0xFFFFECEC);
  static const Color errorFg = Color(0xFFB42318);
  static const Color successBg = Color(0xFFE8F7ED);
  static const Color successFg = Color(0xFF1E7F43);
  static const Color completedBg = Color(0xFFEDEBFF);
  static const Color completedFg = Color(0xFF5B21B6);

  /* =======================
   * Service Card Defaults
   * ======================= */
  static const Color serviceCardBackground = Color(0xFF6F8572);
  static const Color serviceCardTitle = Color(0xFFF2E4CB);
  static const Color serviceCardBody = Color(0xFFE6E9E2);
  static const Color serviceCardAccent = Color(0xFFAFC0A8);
}
