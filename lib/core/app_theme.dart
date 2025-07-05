import 'package:flutter/material.dart';
import 'package:yaru/settings.dart';
import 'package:yaru/theme.dart';

class AppTheme {
  static YaruThemeData of(BuildContext context) {
    return SharedAppData.getValue(
      context,
      'theme',
          () => const YaruThemeData(variant: YaruVariant.viridian),
    );
  }

  static void apply(BuildContext context, {YaruVariant? variant, bool? highContrast, ThemeMode? themeMode,}) {
    SharedAppData.setValue(
      context,
      'theme',
      AppTheme.of(context).copyWith(
        themeMode: themeMode,
        variant: variant,
        highContrast: highContrast,
      ),
    );
  }
}