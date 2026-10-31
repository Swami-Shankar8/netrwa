import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF0F52BA);
  static const Color backgroundColor = Color(0xFFF8FAF9);
  static const Color cardBgLight = Colors.white;

  // Security Alert Colors
  static const Color highRiskRed = Color(0xFFE53935);
  static const Color mediumRiskOrange = Color(0xFFFB8C00);
  static const Color lowRiskGreen = Color(0xFF4CAF50);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        surface: cardBgLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
