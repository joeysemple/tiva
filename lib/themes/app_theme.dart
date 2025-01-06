import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern Color Palette
  static const Color primaryColor = Color(0xFF000000);
  static const Color surfaceColor = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color accentColor = Color(0xFFFF3B5C); // Modern pink-red color similar to TikTok
  static const Color secondaryAccentColor = Color(0xFFE5E5E5);
  
  // Text Colors
  static const Color primaryTextColor = Color(0xFFFFFFFF);
  static const Color secondaryTextColor = Color(0xFFB3B3B3);
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryColor,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        background: primaryColor,
        error: Color(0xFFCF6679),
      ),

      // Modern Typography
      textTheme: GoogleFonts.interTextTheme(
        TextTheme(
          // App name and major titles
          displayLarge: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: primaryTextColor,
          ),
          // Section headers
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: primaryTextColor.withOpacity(0.9),
          ),
          // Sub-headers
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: primaryTextColor,
          ),
          // Body text
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: primaryTextColor.withOpacity(0.9),
            letterSpacing: 0.1,
          ),
          // Secondary text
          bodyMedium: TextStyle(
            fontSize: 14,
            color: secondaryTextColor.withOpacity(0.8),
            letterSpacing: 0.1,
          ),
        ),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),

      // Navigation Bar Theme (Bottom Navigation)
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        backgroundColor: surfaceColor,
        indicatorColor: accentColor.withOpacity(0.12),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accentColor,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: secondaryTextColor.withOpacity(0.8),
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              color: accentColor,
              size: 24,
            );
          }
          return IconThemeData(
            color: secondaryTextColor.withOpacity(0.8),
            size: 24,
          );
        }),
        surfaceTintColor: Colors.transparent,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: primaryTextColor,
        unselectedLabelColor: secondaryTextColor,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.2,
        ),
        indicatorColor: accentColor,
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}