import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF006D77);
  static const Color secondaryColor = Color(0xFF83C5BE);
  static const Color accentColor = Color(0xFFEDF6F9);
  static const Color errorColor = Color(0xFFE29578);
  static const Color successColor = Color(0xFF83C5BE);
  static const Color warningColor = Color(0xFFFFB700);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF1D3557);
  static const Color textSecondary = Color(0xFF457B9D);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: textPrimary,
      onSurface: textPrimary,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: textSecondary,
      indicatorColor: primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
      titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textSecondary),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: textPrimary),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textSecondary),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textSecondary),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: textSecondary),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: secondaryColor,
      secondary: primaryColor,
      surface: const Color(0xFF1D3557),
      error: errorColor,
      onPrimary: textPrimary,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F1C2E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1D3557),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1D3557),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF0F1C2E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryColor, width: 2),
      ),
    ),
  );
}