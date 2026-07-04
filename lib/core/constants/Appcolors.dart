import 'package:flutter/material.dart';

class Appcolors {
  static const Color logoiconcolor = Colors.blue;
  static const Color cwhite = Colors.white;

  static const Color primary = Colors.deepPurple;
  //profile Screen colors
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color appBarBackground = Colors.white;
  static const Color appBarForeground = Colors.black87;
  static const Color buttonColor = Colors.deepPurple;
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color avatarBackground = Color(0xFFF3F0FF);
  static const Color info = Colors.blue;
  static const Color infoLight = Color(0xFFE8EAFF);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color success = Color(0xFF4CAF50);
  static const Color danger = Colors.red;
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFF9E9E9E);

  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      primaryColor: primary,
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: AppBarTheme(
        elevation: 1,
        backgroundColor: appBarBackground,
        foregroundColor: appBarForeground,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: appBarForeground,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
