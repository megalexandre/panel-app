import 'package:flutter/material.dart';

/// Paleta inspirada no tema Dark+ do VS Code.
abstract final class AcalColors {
  // --- Primária (azul VS Code) ---
  static const primary = Color(0xFF007ACC);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFF0E639C);
  static const onPrimaryContainer = Color(0xFFCCE5FF);

  // --- Secundária ---
  static const secondary = Color(0xFF0E639C);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFF252526); // sidebar dark
  static const onSecondaryContainer = Color(0xFFCCCCCC);

  // --- Superfícies dark ---
  static const surface = Color(0xFF1E1E1E);
  static const onSurface = Color(0xFFD4D4D4);
  static const surfaceContainerHighest = Color(0xFF2D2D2D);

  // --- Outline ---
  static const outline = Color(0xFF474747);
  static const outlineVariant = Color(0xFF3C3C3C);

  // --- Erro ---
  static const error = Color(0xFFF48771);
  static const onError = Color(0xFF1E1E1E);
}

/// Paleta light: tons frios e neutros, mesmo azul primário.
abstract final class AcalLightColors {
  static const primary = Color(0xFF007ACC);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFD0E8F8);
  static const onPrimaryContainer = Color(0xFF003E6B);

  static const secondary = Color(0xFF0E639C);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFE8F0F8); // sidebar light
  static const onSecondaryContainer = Color(0xFF003E6B);

  static const surface = Color(0xFFF3F3F3);
  static const onSurface = Color(0xFF1E1E1E);
  static const surfaceContainerHighest = Color(0xFFE8E8E8);

  static const outline = Color(0xFFBDBDBD);
  static const outlineVariant = Color(0xFFD4D4D4);

  static const error = Color(0xFFCD3131);
  static const onError = Color(0xFFFFFFFF);
}

abstract final class AcalTheme {
  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AcalColors.primary,
      onPrimary: AcalColors.onPrimary,
      primaryContainer: AcalColors.primaryContainer,
      onPrimaryContainer: AcalColors.onPrimaryContainer,
      secondary: AcalColors.secondary,
      onSecondary: AcalColors.onSecondary,
      secondaryContainer: AcalColors.secondaryContainer,
      onSecondaryContainer: AcalColors.onSecondaryContainer,
      surface: AcalColors.surface,
      onSurface: AcalColors.onSurface,
      outline: AcalColors.outline,
      outlineVariant: AcalColors.outlineVariant,
      error: AcalColors.error,
      onError: AcalColors.onError,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AcalColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3C3C3C),
        foregroundColor: AcalColors.onSurface,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AcalColors.secondaryContainer,
        indicatorColor: Color(0xFF094771),
        selectedIconTheme: IconThemeData(color: AcalColors.onSurface),
        unselectedIconTheme: IconThemeData(color: Color(0xFF858585)),
        selectedLabelTextStyle: TextStyle(
          color: AcalColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFF858585)),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AcalColors.secondaryContainer,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF252526),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          side: const BorderSide(color: AcalColors.outlineVariant),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AcalColors.outlineVariant,
        space: 1,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color(0xFF3C3C3C),
        hintStyle: TextStyle(color: Color(0xFF858585)),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AcalColors.onSurface),
        bodyLarge: TextStyle(color: AcalColors.onSurface),
        titleMedium: TextStyle(color: AcalColors.onSurface),
        titleLarge: TextStyle(color: AcalColors.onSurface),
      ),
      listTileTheme: const ListTileThemeData(
        selectedTileColor: Color(0xFF094771),
        selectedColor: AcalColors.onSurface,
        textColor: Color(0xFFCCCCCC),
        iconColor: Color(0xFF858585),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF333333),
        contentTextStyle: TextStyle(color: AcalColors.onSurface),
      ),
    );
  }

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AcalLightColors.primary,
      onPrimary: AcalLightColors.onPrimary,
      primaryContainer: AcalLightColors.primaryContainer,
      onPrimaryContainer: AcalLightColors.onPrimaryContainer,
      secondary: AcalLightColors.secondary,
      onSecondary: AcalLightColors.onSecondary,
      secondaryContainer: AcalLightColors.secondaryContainer,
      onSecondaryContainer: AcalLightColors.onSecondaryContainer,
      surface: AcalLightColors.surface,
      onSurface: AcalLightColors.onSurface,
      outline: AcalLightColors.outline,
      outlineVariant: AcalLightColors.outlineVariant,
      error: AcalLightColors.error,
      onError: AcalLightColors.onError,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AcalLightColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFDDDDDD),
        foregroundColor: AcalLightColors.onSurface,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AcalLightColors.secondaryContainer,
        indicatorColor: AcalLightColors.primaryContainer,
        selectedIconTheme: IconThemeData(color: AcalLightColors.primary),
        unselectedIconTheme: IconThemeData(color: Color(0xFF6E6E6E)),
        selectedLabelTextStyle: TextStyle(
          color: AcalLightColors.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFF6E6E6E)),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AcalLightColors.secondaryContainer,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          side: const BorderSide(color: AcalLightColors.outlineVariant),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AcalLightColors.outlineVariant,
        space: 1,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AcalLightColors.onSurface),
        bodyLarge: TextStyle(color: AcalLightColors.onSurface),
        titleMedium: TextStyle(color: AcalLightColors.onSurface),
        titleLarge: TextStyle(color: AcalLightColors.onSurface),
      ),
      listTileTheme: const ListTileThemeData(
        selectedTileColor: AcalLightColors.primaryContainer,
        selectedColor: AcalLightColors.primary,
        textColor: AcalLightColors.onSurface,
        iconColor: Color(0xFF6E6E6E),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF323232),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
