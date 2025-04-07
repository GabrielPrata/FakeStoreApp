import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final BuildContext context;
  double screenWidth = 375;

  AppTheme(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
  }

  static const Color background = Color(0XFF0F2D45);
  static const Color primaryColor = Color(0XFF98C832);
  static const Color secondaryColor = Color(0XFFFFFFFF);
  static const Color successGreen = Color(0XFF2dc653);
  static const Color errorColor = Color(0XFFd00000);
  static const Color yellowWarning = Color(0XFFffd23f);

  ThemeData get mainTheme {
    return ThemeData(
      primaryColor: background,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: background,
        secondary: secondaryColor,
        surface: secondaryColor,
        error: errorColor,
        onPrimary: primaryColor,
        onSecondary: Colors.black,
        onSurface: Colors.grey.shade400,
        onError: errorColor,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: calculate(30),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: calculate(26),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: calculate(20),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: calculate(18),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B1B1B),
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: calculate(20),
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(primaryColor),
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Colors.white,
              width: 1.0, 
            ),
          ),
        ),
      ),
    );
  }

  double calculate(double baseSize) {
    // Define um tamanho base para a largura de 375 pixels (um ponto de referência comum)
    const double baseWidth = 450;

    // Define um fator de escala baseado na largura da tela
    double scaleFactor = screenWidth / baseWidth;

    // Retorna um tamanho de fonte base proporcional
    return baseSize * scaleFactor;
  }
}
