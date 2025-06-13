import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFF0184D6);
  static const secondaryColor = Color(0xFF0E0E0E);
  static const accentColor = Color(0xFFF3FAFF);
  static const appBarColor = Color(0xFFF8F8F8);
  static const warning = Color(0xFFF7A325);
  static const subtleWarning = Color(0xFFFCF4F0);
  static const subtlePrimary = Color(0xFFF4F9FF);
  static const subtlegrey = Color(0xFFF8F8F8);
  static const success = Color(0xFF12B76A);
  static const grey = Color.fromARGB(255, 189, 187, 187);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const  black = Color.fromARGB(255, 15, 15, 15);

  static const cardColors = [
    Color(0xFFFCF4F0),
    Color(0xFFF4F9FF),
    Color(0xFFE9FFF0),
    Color(0xFFF4F1F6),
  ];

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: appBarColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Mark Pro',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.32,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(327, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Mark Pro',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.32,
        ),
      ),
    ),
   
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}
