import 'package:flutter/material.dart';

class AppTokens {
  static const double radiusSm = 12.0;
  static const double radiusMd = 18.0;
  static const double radiusLg = 26.0;
  static const double radiusXl = 34.0;
  static const double radiusPill = 999.0;

  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(radiusLg),
  );
  static const BorderRadius borderRadiusXl = BorderRadius.all(
    Radius.circular(radiusXl),
  );
  static const BorderRadius borderRadiusPill = BorderRadius.all(
    Radius.circular(radiusPill),
  );

  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s32 = 32.0;
  static const double s40 = 40.0;
  static const double s48 = 48.0;

  static const Duration durationFast = Duration(milliseconds: 180);
  static const Duration durationMedium = Duration(milliseconds: 260);
  static const Duration durationSmooth = Duration(milliseconds: 320);

  static List<BoxShadow> softShadow({Color? color}) => [
    BoxShadow(
      color: (color ?? const Color(0xFF6F5548)).withValues(alpha: 0.10),
      blurRadius: 28,
      offset: const Offset(0, 12),
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.40),
      blurRadius: 2,
      offset: const Offset(0, -1),
    ),
  ];
}
