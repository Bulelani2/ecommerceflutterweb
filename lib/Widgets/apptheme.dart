import 'package:flutter/material.dart';

class AppThemes {
  static final Map<String, ThemeData> themes = {
    // 1️⃣ Deep Blue & Gold (Elegant & Trustworthy)
    'Deep Blue & Gold': ThemeData(
      primaryColor: const Color(0xFF0A192F), // Deep Navy Blue
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: const Color(0xFFFFD700)), // Gold
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black54),
      ),
    ),

    // 2️⃣ Dark Purple & Teal (Modern & Bold)
    'Dark Purple & Teal': ThemeData(
      primaryColor: const Color(0xFF4B0082), // Dark Purple
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: const Color(0xFF00A8A8)), // Teal
      scaffoldBackgroundColor: const Color(0xFFEAEAEA), // Light Gray
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
    ),

    // 3️⃣ Charcoal & Bright Orange (Bold & Professional)
    'Charcoal & Bright Orange': ThemeData(
      primaryColor: const Color(0xFF333333), // Charcoal
      hintColor: const Color(0xFFFF6F00), // Bright Orange
      scaffoldBackgroundColor: const Color(0xFFFAFAFA), // Soft White
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
    ),

    // 4️⃣ Black, White & Electric Blue (Minimal & Futuristic)
    'Black, White & Electric Blue': ThemeData(
      primaryColor: const Color(0xFF121212), // Jet Black
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: const Color(0xFF007BFF)), // Electric Blue
      scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Cool Gray
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
    ),
  };

  // Function to get theme by name
  static ThemeData getTheme(String themeName) {
    return themes[themeName] ?? themes['Deep Blue & Gold']!; // Default theme
  }
}
