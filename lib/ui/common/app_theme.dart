import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';

ThemeData buildTheme(Brightness brightness) {
  ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: appColorPrimaryDark,
    surface: appColorPrimaryDark,
    onSurface: appColorTextWhite,
    primary: appColorPrimaryBlueAccent,
    onPrimary: appColorTextWhiteGrey,
    primaryContainer: appColorPrimarySoft,
    onPrimaryContainer: appColorPrimaryBlueAccent,
    secondary: appColorSecOrange,
    onSecondary: appColorTextWhite,
    secondaryContainer: appColorPrimarySoft,
    onSecondaryContainer: appColorSecOrange,
    brightness: brightness,
  );
  final baseTheme =
      ThemeData.from(colorScheme: colorScheme, useMaterial3: true);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.montserratTextTheme(baseTheme.textTheme).copyWith(
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 28,
      ),
      bodyMedium:
          GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(
            color: appColorPrimaryBlueAccent,
          ),
        )),
    buttonTheme: ButtonThemeData(
        buttonColor: appColorPrimaryBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(appColorPrimaryBlueAccent),
        foregroundColor: WidgetStateProperty.all(appColorTextWhite),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  );
}

ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(appColorSecOrange),
    foregroundColor: WidgetStateProperty.all(appColorTextWhite),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ));
