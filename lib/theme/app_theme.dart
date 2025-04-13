import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFD700);
  static const Color secondaryColor = Color(0xFFFFA000);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF212121);
  static const Color greyColor = Color(0xFF9E9E9E);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: Color(0xFFFFD700), // Gold
        secondary: Color(0xFFB8860B), // DarkGoldenrod
        surface: Colors.white,
        background: Color(0xFFF5F5F5),
        error: Colors.red,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFFFD700),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFD700),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFFFD700), // Gold
        secondary: Color(0xFFB8860B), // DarkGoldenrod
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
        error: Colors.red,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Color(0xFFFFD700),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFD700),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: Color(0xFF1E1E1E),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static BoxDecoration glassmorphismDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1.5,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  );

  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor.withOpacity(0.8),
        secondaryColor.withOpacity(0.8),
      ],
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  );
} 