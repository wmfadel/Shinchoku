import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextTheme _lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.montserratAlternates(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.montserratAlternates(
      fontSize: 32.0.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.montserratAlternates(
      fontSize: 21.0.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.montserratAlternates(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.montserratAlternates(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.montserratAlternates(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.montserratAlternates(
      fontSize: 32.0.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.montserratAlternates(
      fontSize: 21.0.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.montserratAlternates(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.montserratAlternates(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static const ColorScheme _customColorScheme = ColorScheme(
    primary: Color(0xff518099),
    secondary: Color(0xffff844b),
    surface: Color(0xff61D5A1),
    background: Colors.white,
    error: Color(0xff518099),
    onPrimary: Colors.red,
    onSecondary: Colors.deepOrange,
    onSurface: Color(0xff61D5A1),
    onBackground: Color(0xffA8EA87),
    onError: Colors.redAccent,
    brightness: Brightness.light,
  );

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            return _customColorScheme.primary;
          }),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: _customColorScheme.secondary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: _customColorScheme.secondary,
        ),
        colorScheme: _customColorScheme,
        textTheme: _lightTextTheme,
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: _customColorScheme.surface,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: _customColorScheme.secondary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: _customColorScheme.secondary,
        ),
        colorScheme: _customColorScheme,
        textTheme: _darkTextTheme,
      );
}
