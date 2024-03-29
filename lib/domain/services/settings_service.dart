import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';

abstract class SettingsService {
  AppSettings get appSettings;

  AppThemeType get appTheme;
  set appTheme(AppThemeType theme);

  AppLanguageType get language;
  set language(AppLanguageType lang);

  bool get isFirstInstall;
  set isFirstInstall(bool itIs);

  bool get doubleBackToClose;
  set doubleBackToClose(bool value);

  bool get isProfileHeaderSet;
  set isProfileHeaderSet(bool value);

  String get headerPath;
  set headerPath(String value);

  bool get useDemoImage;
  set useDemoImage(bool value);

  AutoThemeModeType get autoThemeMode;
  set autoThemeMode(AutoThemeModeType themeMode);

  Future<void> init();
}