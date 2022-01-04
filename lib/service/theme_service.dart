import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import './shared_perferences_service.dart';
import 'package:provider/provider.dart';

enum AppTheme {
  darkTheme,
  lightTheme,
}

class ThemeService with ChangeNotifier {
  static const String defaultThemeValue = 'default';
  static const String darkThemeValue = 'dark';
  static const String lightThemeValue = 'light';
  static final systemDefaultTheme =
      SchedulerBinding.instance!.window.platformBrightness;
  static final darkTheme = ThemeData(
    // fontFamily: 'Ubuntu',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFBC02D),
    ),
  );
  static final lightTheme = ThemeData(
    // fontFamily: 'Ubuntu',
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1E88E5),
    ),
  );

  Future<String> _checkThemeMode = SharedPreferencesService.checkThemeMode();
  Future<String> get checkThemeMode => _checkThemeMode;

  void checkThemeModeEnabled() {
    _checkThemeMode = SharedPreferencesService.checkThemeMode();
    notifyListeners();
  }

  static Future<void> setDarkMode(BuildContext context) async {
    await SharedPreferencesService.setDarkMode();
    context.read<ThemeService>().checkThemeModeEnabled();
  }

  static Future<void> setLightMode(BuildContext context) async {
    await SharedPreferencesService.setLightMode();
    context.read<ThemeService>().checkThemeModeEnabled();
  }

  static Future<void> setSystemDefaultMode(BuildContext context) async {
    await SharedPreferencesService.setSystemDefaultMode();
    context.read<ThemeService>().checkThemeModeEnabled();
  }
}
