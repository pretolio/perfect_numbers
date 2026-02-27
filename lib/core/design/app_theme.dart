import 'package:flutter/material.dart';

/// Design System - Cores, espaçamentos e estilos padronizados
class AppTheme {
  AppTheme._();

  // Border Radius padrão
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static BorderRadius get borderRadiusSmall => BorderRadius.circular(radiusSmall);
  static BorderRadius get borderRadiusMedium => BorderRadius.circular(radiusMedium);
  static BorderRadius get borderRadiusLarge => BorderRadius.circular(radiusLarge);

  // Espaçamentos
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // Cores neutras principais
  static const Color primary = Color(0xFF2D3748);      // Cinza escuro
  static const Color primaryLight = Color(0xFF4A5568); // Cinza médio
  static const Color secondary = Color(0xFF718096);    // Cinza

  // Cores de fundo
  static const Color backgroundLight = Color(0xFFF7FAFC);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFFE2E8F0);

  // Cores de texto
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textMuted = Color(0xFF718096);
  static const Color textLight = Color(0xFFFFFFFF);

  // Cores de estado (mais sutis)
  static const Color success = Color(0xFF38A169);       // Verde
  static const Color successLight = Color(0xFFC6F6D5);  // Verde claro
  static const Color warning = Color(0xFFD69E2E);       // Amarelo/Laranja
  static const Color warningLight = Color(0xFFFEFCBF);  // Amarelo claro
  static const Color error = Color(0xFFE53E3E);         // Vermelho
  static const Color errorLight = Color(0xFFFED7D7);    // Vermelho claro
  static const Color info = Color(0xFF3182CE);          // Azul
  static const Color infoLight = Color(0xFFBEE3F8);     // Azul claro

  // Cores para chips/tags
  static const Color chipBackground = Color(0xFFEDF2F7);
  static const Color chipText = Color(0xFF2D3748);

  // Elevações
  static const double elevationNone = 0.0;
  static const double elevationLow = 1.0;
  static const double elevationMedium = 2.0;
  static const double elevationHigh = 4.0;

  // Tema do Material 3
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: textLight,
        elevation: elevationNone,
      ),
      cardTheme: CardThemeData(
        color: backgroundCard,
        elevation: elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textLight,
          elevation: elevationNone,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLg,
            vertical: spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMedium,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundCard,
        border: OutlineInputBorder(
          borderRadius: borderRadiusMedium,
          borderSide: const BorderSide(color: backgroundDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadiusMedium,
          borderSide: const BorderSide(color: backgroundDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadiusMedium,
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingMd,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: chipBackground,
        labelStyle: const TextStyle(color: chipText),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusSmall,
        ),
        side: BorderSide.none,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: backgroundCard,
        indicatorColor: backgroundDark,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: textMuted,
            fontSize: 12,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primary);
          }
          return const IconThemeData(color: textMuted);
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium,
        ),
      ),
    );
  }
}
