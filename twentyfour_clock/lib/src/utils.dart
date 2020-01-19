import 'dart:math' as math;

import 'package:flutter/material.dart';

class Constants {
  static const INNER_PADDING = 2.0;
  static const MAIN_PADDING = 10.0;

  /// Style
  static final Color black = Color(0xFF1C1C1C);
  static final Color darkGray = Color(0xFF413D3D);
  static final Color paleGold = Color(0xFFF1D3B4);
}

class ClockUtils {
  /// Total distance traveled by a second or a minute hand, each second or minute,
  /// respectively.
  static final radiansPerTick = radians(360 / 60);

  /// Total distance traveled by an hour hand, each hour, in radians.
  static final radiansPerHour = radians(360 / 12);

  /// Convert degrees to radians
  static double radians(double d) => d * (math.pi / 180);

  static double sizeOfContext(BuildContext context) =>
      MediaQuery.of(context).size.width / 8 - Constants.INNER_PADDING * 8;

  static final digits = [
    [
      // 0
      {"hour": 6, "minute": 15},
      {"hour": 9, "minute": 30},
      {"hour": 6, "minute": 0},
      {"hour": 0, "minute": 30},
      {"hour": 3, "minute": 0},
      {"hour": 0, "minute": 45}
    ],
    [
      // 1
      {"hour": 7.5, "minute": 37.5},
      {"hour": 6, "minute": 30},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 6, "minute": 0},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 0, "minute": 0}
    ],
    [
      // 2
      {"hour": 3, "minute": 15},
      {"hour": 9, "minute": 30},
      {"hour": 6, "minute": 15},
      {"hour": 0, "minute": 45},
      {"hour": 0, "minute": 15},
      {"hour": 9, "minute": 45}
    ],
    [
      // 3
      {"hour": 3, "minute": 15},
      {"hour": 9, "minute": 30},
      {"hour": 3, "minute": 15},
      {"hour": 9, "minute": 0},
      {"hour": 3, "minute": 15},
      {"hour": 9, "minute": 0}
    ],
    [
      // 4
      {"hour": 6, "minute": 30},
      {"hour": 6, "minute": 30},
      {"hour": 0, "minute": 15},
      {"hour": 6, "minute": 0},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 0, "minute": 0}
    ],
    [
      // 5
      {"hour": 6, "minute": 15},
      {"hour": 9, "minute": 45},
      {"hour": 0, "minute": 15},
      {"hour": 6, "minute": 45},
      {"hour": 3, "minute": 15},
      {"hour": 0, "minute": 45}
    ],
    [
      // 6
      {"hour": 6, "minute": 15},
      {"hour": 9, "minute": 45},
      {"hour": 6, "minute": 0},
      {"hour": 6, "minute": 45},
      {"hour": 0, "minute": 15},
      {"hour": 0, "minute": 45}
    ],
    [
      // 7
      {"hour": 3, "minute": 15},
      {"hour": 6, "minute": 45},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 6, "minute": 0},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 0, "minute": 0}
    ],
    [
      // 8
      {"hour": 6, "minute": 15},
      {"hour": 6, "minute": 45},
      {"hour": 0, "minute": 15},
      {"hour": 0, "minute": 45},
      {"hour": 0, "minute": 15},
      {"hour": 0, "minute": 45}
    ],
    [
      // 9
      {"hour": 6, "minute": 15},
      {"hour": 6, "minute": 45},
      {"hour": 3, "minute": 0},
      {"hour": 6, "minute": 0},
      {"hour": 3, "minute": 15},
      {"hour": 0, "minute": 45}
    ],
    [
      // F
      {"hour": 6, "minute": 15},
      {"hour": 9, "minute": 45},
      {"hour": 6, "minute": 0},
      {"hour": 9, "minute": 45},
      {"hour": 0, "minute": 0},
      {"hour": 7.5, "minute": 37.5},
    ],
    [
      // C
      {"hour": 6, "minute": 15},
      {"hour": 9, "minute": 45},
      {"hour": 6, "minute": 0},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 3, "minute": 0},
      {"hour": 9, "minute": 45}
    ],
    [
      // Degrees
      {"hour": 6, "minute": 15},
      {"hour": 9, "minute": 30},
      {"hour": 3, "minute": 0},
      {"hour": 9, "minute": 0},
      {"hour": 7.5, "minute": 37.5},
      {"hour": 7.5, "minute": 37.5},
    ]
  ];

  static double getHourOfIndex(int number, int index) =>
      digits[number][index]["hour"].toDouble();

  static double getMinuteOfIndex(int number, int index) =>
      digits[number][index]["minute"].toDouble();
}

extension DateTimeUtils on DateTime {
  int hourFirstDigit() => _firstDigit(this.hour);

  int minuteFirstDigit() => _firstDigit(this.minute);

  int hourSecondDigit() => _secondDigit(this.hour);

  int minuteSecondDigit() => _secondDigit(this.minute);

  int _firstDigit(int number) => number ~/ 10;

  int _secondDigit(int number) => number % 10;
}

extension ThemeExtension on Theme {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
