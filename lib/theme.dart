import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kTextDark = Colors.black;
Color kTextLight = Colors.white;

class IversonTheme {
  static Typography textTypography = Typography.material2021(black: Typography().black, white: Typography().white);

  static TextTheme textTheme = ThemeData.light().textTheme;

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.sora(textStyle: textTheme.displayLarge),
    displayMedium: GoogleFonts.sora(textStyle: textTheme.displayMedium),
    displaySmall: GoogleFonts.sora(textStyle: textTheme.displaySmall),
    headlineLarge: GoogleFonts.sora(textStyle: textTheme.headlineLarge),
    headlineMedium: GoogleFonts.sora(textStyle: textTheme.headlineMedium),
    headlineSmall: GoogleFonts.sora(textStyle: textTheme.headlineSmall),
    titleLarge: GoogleFonts.sora(textStyle: textTheme.titleLarge),
    titleMedium: GoogleFonts.sora(textStyle: textTheme.titleMedium),
    titleSmall: GoogleFonts.sora(textStyle: textTheme.titleSmall),
    bodyLarge: GoogleFonts.sora(textStyle: textTheme.bodyLarge),
    bodyMedium: GoogleFonts.sora(textStyle: textTheme.bodyMedium),
    bodySmall: GoogleFonts.sora(textStyle: textTheme.bodySmall),
    labelLarge: GoogleFonts.sora(textStyle: textTheme.labelLarge),
    labelMedium: GoogleFonts.sora(textStyle: textTheme.labelMedium),
    labelSmall: GoogleFonts.sora(textStyle: textTheme.labelSmall),
  );

  static ThemeData light() {
    return ThemeData(
      dividerColor: const Color(0xFFF9F9F9),
      bottomAppBarColor: const Color(0xFFF1F1F1),
      canvasColor: Colors.grey[50],
      cardColor: Colors.white,
      shadowColor: const Color(0xFFC3EDDA),
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF1F1F1),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      typography: textTypography,
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFF216869),
      colorScheme: const ColorScheme.light(primary: Color(0xFF216869)).copyWith(secondary: const Color(0xFFB8D8BA)),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      dividerColor: Colors.black,
      bottomAppBarColor: const Color(0xFF272C2F),
      canvasColor: Colors.black54,
      cardColor: Colors.grey.shade900,
      shadowColor: const Color(0xFF192C31),
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF000000),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      typography: textTypography,
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFF216869),
      colorScheme: const ColorScheme.dark(primary: Color(0xFF216869)).copyWith(secondary: const Color(0xFFB8D8BA)),
    );
  }
}