import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeBuilder {
  static ThemeData get lightTheme => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 0, 0, 0),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color.fromARGB(255, 0, 179, 39),
          onPrimaryContainer: Color(0xFFFFFFFF),
          secondary: Color(0xFF03DAC6),
          onSecondary: Color(0xFF000000),
          secondaryContainer: Color(0xFF018786),
          onSecondaryContainer: Color(0xFF000000),
          tertiary: Color(0xFF03DAC6),
          onTertiary: Color(0xFF000000),
          tertiaryContainer: Colors.white,
          error: Color.fromARGB(255, 255, 107, 97),
          onError: Colors.white,
          surface: Color.fromARGB(255, 230, 230, 230),
          onSurface: Colors.black,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFBB86FC),
          onPrimary: Color(0xFF000000),
          primaryContainer: Color(0xFF3700B3),
          onPrimaryContainer: Color(0xFFFFFFFF),
          secondary: Color(0xFF03DAC6),
          onSecondary: Color(0xFF000000),
          secondaryContainer: Color(0xFF018786),
          onSecondaryContainer: Color(0xFF000000),
          tertiary: Color(0xFF03DAC6),
          onTertiary: Color(0xFF000000),
          tertiaryContainer: Colors.white,
          error: Color.fromARGB(255, 255, 107, 97),
          onError: Colors.white,
          surface: Color.fromARGB(255, 31, 31, 31),
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      );
}
