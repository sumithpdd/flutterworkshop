// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppConstants {
  static const String APP_PRIMARY_COLOR = "#3b8c42";
  static const String APP_BACKGROUND_COLOR = "#F6F8F9";
  static const String APP_BACKGROUND_COLOR_WHITE = "#FFFFFF";
  static const String APP_PRIMARY_COLOR_LIGHT = "#9f9f9f";

  static const String APP_PRIMARY_COLOR_BLACK = "#000000";
  static const String APP_PRIMARY_FONT_COLOR_WHITE = "#FFFFFF";
  static const String APP_PRIMARY_FONT_COLOR_LIGHT = "#9f9f9f";

  static const String APP_PRIMARY_COLOR_ACTION = "#3b8c42";
  static const String APP_PRIMARY_TILE_COLOR = "#7aa786";
  static const String APP_PRIMARY_COLOR_GREEN = "#3b8c42";
  static const String APP_BACKGROUND_COLOR_GRAY = "#D0D0D0";

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static MaterialColor colorToMaterialColor(Color color) {
    return MaterialColor(color.value, getSwatch(color));
  }
}

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  const lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  const highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}
