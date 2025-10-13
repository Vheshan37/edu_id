import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: const Color(0xFFF9FAFB), // subtle off-white
      primary: const Color(0xFF253664), // deep blue
      secondary: const Color(0xFF22C55E), // green
      tertiary: const Color(0xFFF59E0B), // orange accent
      surface: const Color(0xFFADBEED), // light surface
      onBackground: Colors.black87,
      onPrimary: const Color(0xFF253664),
      onSecondary: const Color(0xFF283D71),
    ),
    scaffoldBackgroundColor: const Color(0xFFF9FAFB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF253664),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Color(0xFF253664),
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(color: Color(0xFF888888), fontSize: 14),
      labelLarge: TextStyle(
        color: Color(0xFF253664),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF253664),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF253664)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF1E3A8A), width: 1.8),
      ),
    ),
  );

  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: const Color(0xFF0D1117), // dark grey
      primary: const Color(0xFF253664),
      secondary: const Color(0xFF22C55E),
      tertiary: const Color(0xFFF59E0B),
      surface: const Color(0xFF1A1F25),
      onBackground: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Color(0xFF888888),
    ),
    scaffoldBackgroundColor: const Color(0xFF0D1117),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF253664),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(color: Color(0xFFADBEED), fontSize: 14),
      labelLarge: TextStyle(
        color: Color(0xFF22C55E),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF253664),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1F25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFADBEED)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF1E3A8A), width: 1.8),
      ),
    ),
  );
}
