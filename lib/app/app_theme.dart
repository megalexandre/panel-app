import 'package:flutter/material.dart';

/// Paleta de cores completa do design system.
abstract final class AcalPalette {
  // Primary
  static const primary100 = Color(0xFFE6EFFF);
  static const primary200 = Color(0xFFC2D6FF);
  static const primary300 = Color(0xFF99B8FF);
  static const primary400 = Color(0xFF6690FF);
  static const primary500 = Color(0xFF3366FF);
  static const primary600 = Color(0xFF254EDB);
  static const primary700 = Color(0xFF1938B8);
  static const primary800 = Color(0xFF102494);
  static const primary900 = Color(0xFF091370);

  // Success
  static const success100 = Color(0xFFF1FCE3);
  static const success200 = Color(0xFFDAF7B8);
  static const success300 = Color(0xFFC2F08C);
  static const success400 = Color(0xFFA8EA5C);
  static const success500 = Color(0xFF8BE218);
  static const success600 = Color(0xFF6CBF10);
  static const success700 = Color(0xFF509C09);
  static const success800 = Color(0xFF367A04);
  static const success900 = Color(0xFF205701);

  // Info
  static const info100 = Color(0xFFE3F6FE);
  static const info200 = Color(0xFFB8E8FD);
  static const info300 = Color(0xFF8AD9FC);
  static const info400 = Color(0xFF5CC9FA);
  static const info500 = Color(0xFF45BEF7);
  static const info600 = Color(0xFF3095D4);
  static const info700 = Color(0xFF1F6FB0);
  static const info800 = Color(0xFF114D8C);
  static const info900 = Color(0xFF062F69);

  // Warning
  static const warning100 = Color(0xFFFFF6E5);
  static const warning200 = Color(0xFFFFE6B8);
  static const warning300 = Color(0xFFFFD48A);
  static const warning400 = Color(0xFFFFC15C);
  static const warning500 = Color(0xFFFFB83F);
  static const warning600 = Color(0xFFDB932A);
  static const warning700 = Color(0xFFB87219);
  static const warning800 = Color(0xFF94530B);
  static const warning900 = Color(0xFF703803);

  // Danger
  static const danger100 = Color(0xFFFFE8E5);
  static const danger200 = Color(0xFFFFC2B8);
  static const danger300 = Color(0xFFFF988A);
  static const danger400 = Color(0xFFFF6C5C);
  static const danger500 = Color(0xFFFF4032);
  static const danger600 = Color(0xFFDB2721);
  static const danger700 = Color(0xFFB81514);
  static const danger800 = Color(0xFF94080B);
  static const danger900 = Color(0xFF700206);
}

/// Tokens semânticos — tema dark.
abstract final class AcalColors {
  // --- Primária ---
  static const primary = AcalPalette.primary500;
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = AcalPalette.primary700;
  static const onPrimaryContainer = AcalPalette.primary100;

  // --- Secundária ---
  static const secondary = AcalPalette.primary600;
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

  // --- Semânticas ---
  static const error = AcalPalette.danger400;
  static const onError = Color(0xFF1E1E1E);
  static const success = AcalPalette.success500;
  static const onSuccess = Color(0xFF1E1E1E);
  static const info = AcalPalette.info500;
  static const onInfo = Color(0xFF1E1E1E);
  static const warning = AcalPalette.warning500;
  static const onWarning = Color(0xFF1E1E1E);
}

/// Tokens semânticos — tema light.
abstract final class AcalLightColors {
  // --- Primária ---
  static const primary = AcalPalette.primary500;
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = AcalPalette.primary100;
  static const onPrimaryContainer = AcalPalette.primary900;

  // --- Secundária ---
  static const secondary = AcalPalette.primary600;
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFEEF3FF); // sidebar light
  static const onSecondaryContainer = AcalPalette.primary900;

  // --- Superfícies light ---
  static const surface = Color(0xFFF3F3F3);
  static const onSurface = Color(0xFF1E1E1E);
  static const surfaceContainerHighest = Color(0xFFE8E8E8);

  // --- Outline ---
  static const outline = Color(0xFFBDBDBD);
  static const outlineVariant = Color(0xFFD4D4D4);

  // --- Semânticas ---
  static const error = AcalPalette.danger600;
  static const onError = Color(0xFFFFFFFF);
  static const success = AcalPalette.success600;
  static const onSuccess = Color(0xFFFFFFFF);
  static const info = AcalPalette.info700;
  static const onInfo = Color(0xFFFFFFFF);
  static const warning = AcalPalette.warning600;
  static const onWarning = Color(0xFFFFFFFF);
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
        indicatorColor: AcalPalette.primary800,
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
        selectedTileColor: AcalPalette.primary800,
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
