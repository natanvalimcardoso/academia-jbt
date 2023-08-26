import 'package:flutter/material.dart';

class AppConfigUI {
  AppConfigUI._();

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF800080,
    <int, Color>{
      50: Color(0xFFE6E6FA),
      100: Color(0xFFD8BFD8),
      200: Color(0xFFC71585),
      300: Color(0xFFB03060),
      400: Color(0xFF9932CC),
      500: Color(0xFF800080),
      600: Color(0xFF8A2BE2),
      700: Color(0xFF7B68EE),
      800: Color(0xFF4B0082),
      900: Color(0xFF483D8B),
    },
  );

  static final ThemeData theme = ThemeData(
    primaryColor: const Color(0xFF800080),
    primaryColorLight: const Color(0xFF9370DB),
    primarySwatch: primarySwatch,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      labelStyle: const TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
