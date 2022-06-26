import 'package:flutter/material.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/theme.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData getThemeData(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.light:
        return IversonTheme.light();
      case AppThemeType.dark:
        return IversonTheme.dark();
      default:
        throw Exception('Invalid theme type = $theme');
    }
  }
}