// theme.dart
import 'package:flutter/material.dart';

// Define primary colors, text colors, etc.
class AppColors {
  static const Color primary = Color(0xFF077d2e); // Customize as needed
  static const Color accent = Color(0xFF03DAC6);
  static const Color background = Color(0xFFF2F2F2);
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF757575);
  static const Color error = Color(0xFFB00020);
}

// Define text styles
class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

// Define Button Theme
final ButtonStyle elevatedButtonStyle =
 ElevatedButton.styleFrom(
  backgroundColor: AppColors.primary, // Background color
  // : Colors.white,    // Text color
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  textStyle: AppTextStyles.bodyText1,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

// Input Field Theme
final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.primary),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.primary, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.error),
  ),
);
