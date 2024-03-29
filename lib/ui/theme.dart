import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFF10477a),
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: const Color(0xFF0097A7),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.black),
  dividerColor: Colors.white,
);

final lightTheme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
  primarySwatch: Colors.blueGrey,
  primaryColor: Color(0xFF10477a),
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFFFFFFE),
  accentColor: Color(0xFF0097A7),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.deepOrange),
  dividerColor: Colors.black,
);
