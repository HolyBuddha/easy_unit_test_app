import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static const Color scaffoldBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static final ThemeData themeData = ThemeData(
      fontFamily: GoogleFonts.onest().fontFamily,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontFamily: GoogleFonts.mulish().fontFamily,
          fontSize: 15,
          letterSpacing: -0.4,
        ),
        titleLarge: const TextStyle(
          color: Colors.black,
          fontSize: 34,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.grey,
        selectionHandleColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: scaffoldBackgroundColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ));
}
