import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_shop/service/theme_service.dart';

import 'encryption_service.dart';

final _prefs = SharedPreferences.getInstance();

class SharedPreferencesService {
  static final String themeModeKey = EncryptionService.encrypt(
    text: 'theme_mode',
  );
  static Future<String> checkThemeMode() async {
    final SharedPreferences prefs = await _prefs;
    final String? themeMode = prefs.get(themeModeKey) as String?;
    return themeMode ?? ThemeService.defaultThemeValue;
  }

  static Future<void> setDarkMode() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(themeModeKey, ThemeService.darkThemeValue);
  }

  static Future<void> setLightMode() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(themeModeKey, ThemeService.lightThemeValue);
  }

  static Future<void> setSystemDefaultMode() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(themeModeKey);
  }
}
