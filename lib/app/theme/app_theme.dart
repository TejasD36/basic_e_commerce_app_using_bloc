import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colour_palette.dart';

class AppTheme {
  static const String _font = 'Poppins';

  /// Common radius
  static const double _radiusSmall = 6;
  static const double _borderWidth = 0.2;
  static const double _radiusMedium = 12;
  static const double _radiusLarge = 16;

  static ThemeData get light => _buildTheme(Brightness.light);

  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    final baseScheme = ColorScheme.fromSeed(seedColor: AppColourPalette.primary, brightness: brightness);

    final colorScheme = baseScheme.copyWith(
      primary: AppColourPalette.primary,
      onPrimary: AppColourPalette.white,
      onSecondary: AppColourPalette.white,
      tertiary: AppColourPalette.green,
      onTertiary: AppColourPalette.white,
      error: AppColourPalette.red,
      onError: AppColourPalette.white,
      surface: isLight ? AppColourPalette.lightSurface : AppColourPalette.darkSurface,
      onSurface: isLight ? AppColourPalette.black : AppColourPalette.white,
      onSurfaceVariant: isLight ? AppColourPalette.grey : AppColourPalette.lightGrey,
    );

    final textTheme = _createTextTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: _font,
      colorScheme: colorScheme,
      textTheme: textTheme,

      /// Scaffold
      scaffoldBackgroundColor: isLight ? AppColourPalette.lightSurface : AppColourPalette.darkSurface,

      /// APP BAR
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        // iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
        // actionsIconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
        titleSpacing: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: isLight ? AppColourPalette.white : AppColourPalette.black,
          systemNavigationBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        ),
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.surface,
        headerBackgroundColor: colorScheme.primary,
        headerForegroundColor: colorScheme.onPrimary,
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary;
          }
          return colorScheme.onSurface;
        }),

        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        todayForegroundColor: WidgetStateProperty.all(colorScheme.primary),
        todayBackgroundColor: WidgetStateProperty.all(colorScheme.primary.withValues(alpha: 0.15)),
        yearForegroundColor: WidgetStateProperty.all(colorScheme.onSurface),
        yearBackgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusMedium)),
        dividerColor: colorScheme.outlineVariant,
      ),

      /// CARD
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
      ),

      /// DIALOG
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusMedium)),
      ),

      /// SNACKBAR
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
      ),

      /// DIVIDER
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant, thickness: 1),

      /// BUTTONS
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(const Size.fromHeight(50)),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return brightness == Brightness.light ? Color(0xFFDCE9E7) : Color(0xFF334B45).withValues(alpha: 0.4);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary.withValues(alpha: 0.8);
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary.withValues(alpha: 0.9);
            }
            return colorScheme.primary;
          }),

          textStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);
            }

            if (states.contains(WidgetState.pressed)) {
              return textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);
            }

            return textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return brightness == Brightness.light ? colorScheme.primary : colorScheme.onPrimary.withValues(alpha: 0.6);
            }
            return colorScheme.onPrimary;
          }),

          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.onPrimary.withValues(alpha: 0.12);
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.onPrimary.withValues(alpha: 0.08);
            }
            return null;
          }),

          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall))),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusSmall)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radiusLarge)),
        ),
      ),

      /// INPUT FIELD
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        constraints: BoxConstraints(minHeight: 50),
        fillColor: isLight ? AppColourPalette.white : const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        suffixIconConstraints: BoxConstraints(minWidth: 50, minHeight: 24, maxWidth: 100, maxHeight: 50),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusSmall),
          borderSide: BorderSide(color: AppColourPalette.lightGrey, width: _borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusSmall),
          borderSide: BorderSide(color: AppColourPalette.lightGrey, width: _borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusSmall),
          borderSide: BorderSide(color: colorScheme.primary, width: _borderWidth),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusSmall),
          borderSide: BorderSide(color: colorScheme.error, width: _borderWidth),
        ),

        hintStyle: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
        labelStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
        floatingLabelStyle: textTheme.titleSmall?.copyWith(color: colorScheme.primary),
      ),

      /// CHECKBOX
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
      ),

      /// SWITCH
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(colorScheme.primary),
        trackColor: WidgetStateProperty.all(colorScheme.primary.withValues(alpha: 0.4)),
      ),

      /// RADIO
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(colorScheme.primary)),

      /// LIST TILE
      listTileTheme: ListTileThemeData(iconColor: colorScheme.onSurface, textColor: colorScheme.onSurface),

      /// BOTTOM NAVIGATION
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
      ),

      /// PROGRESS INDICATOR
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.primary),

      /// TEXT SELECTION
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withValues(alpha: 0.3),
        selectionHandleColor: colorScheme.primary,
      ),
    );
  }

  static TextTheme _createTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      /// =========================================================
      /// DISPLAY → bold (Large hero / marketing text)
      /// =========================================================
      displayLarge: _baseStyle(32, colorScheme.onSurface, FontWeight.w700),
      // bold
      displayMedium: _baseStyle(28, colorScheme.onSurface, FontWeight.w700),
      // bold
      displaySmall: _baseStyle(24, colorScheme.onSurface, FontWeight.w700),
      // bold

      /// =========================================================
      /// HEADLINE → semiBold / bold (Screen titles)
      /// =========================================================
      headlineLarge: _baseStyle(24, colorScheme.onSurface, FontWeight.w600),
      // semiBold
      headlineMedium: _baseStyle(22, colorScheme.onSurface, FontWeight.w600),
      // semiBold
      headlineSmall: _baseStyle(20, colorScheme.onSurface, FontWeight.w700),
      // bold

      /// =========================================================
      /// TITLE → medium / semiBold (Section titles)
      /// =========================================================
      titleLarge: _baseStyle(18, colorScheme.onSurface, FontWeight.w600),
      // semiBold
      titleMedium: _baseStyle(16, colorScheme.onSurface, FontWeight.w500),
      // medium
      titleSmall: _baseStyle(14, colorScheme.onSurface, FontWeight.w500),
      // medium

      /// =========================================================
      /// BODY → regular (Normal content)
      /// =========================================================
      bodyLarge: _baseStyle(16, colorScheme.onSurface, FontWeight.w400),
      // regular
      bodyMedium: _baseStyle(14, colorScheme.onSurface, FontWeight.w400),
      // regular
      bodySmall: _baseStyle(12, colorScheme.onSurfaceVariant, FontWeight.w400),
      // regular

      /// =========================================================
      /// LABEL → medium (Buttons, captions, UI labels)
      /// =========================================================
      labelLarge: _baseStyle(14, colorScheme.onSurface, FontWeight.w500),
      // medium
      labelMedium: _baseStyle(12, colorScheme.onSurfaceVariant, FontWeight.w500),
      // medium
      labelSmall: _baseStyle(11, colorScheme.onSurfaceVariant, FontWeight.w500), // medium
    );
  }

  static TextStyle _baseStyle(double size, Color color, [FontWeight weight = FontWeight.w400]) {
    return TextStyle(fontFamily: _font, fontSize: size, fontWeight: weight, color: color);
  }
}
