import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData temaEscuro() {
  final baseTheme = ThemeData(
    fontFamily: "Open Sans",
  );

  return baseTheme.copyWith(
    brightness: Brightness.dark,

    primaryColor: const Color(0xFFFF8C00),      // laranja suave
    primaryColorLight: const Color(0xFFFFA733), // laranja claro
    primaryColorDark: const Color(0xFF1F1F1F),  // cinza escuro

    highlightColor: Colors.white70, // branco mais suave
  );
}