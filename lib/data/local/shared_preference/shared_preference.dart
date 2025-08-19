import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';


class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;
  static const String _currentLocalKey = 'current_local';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set key
  static Future<void> setBool(String boolKey, bool boolVal) =>
      _sharedPreferences.setBool(boolKey, boolVal);

  static Future<void> setString(String stringKey, String stringVal) =>
      _sharedPreferences.setString(stringKey, stringVal);

  static Future<void> setInt(String intKey, int intVal) =>
      _sharedPreferences.setInt(intKey, intVal);

  static Future<void> setDouble(String doubleKey, double doubleVal) =>
      _sharedPreferences.setDouble(doubleKey, doubleVal);

  /// get key
  static bool? getBool(String boolKey) => _sharedPreferences.getBool(boolKey);

  static String? getString(String stringKey) =>
      _sharedPreferences.getString(stringKey);

  static int? getInt(String intKey) => _sharedPreferences.getInt(intKey);

  static double? getDouble(String doubleKey) =>
      _sharedPreferences.getDouble(doubleKey);

  /// clear all data from shared pref
  static Future<void> clearPrefs() async => await _sharedPreferences.clear();

  /// clear key
  static Future<void> clearKey(String key) async =>
      await _sharedPreferences.remove(key);

  /// save current locale
  static Future<void> setCurrentLanguage(String languageCode) =>
      _sharedPreferences.setString(_currentLocalKey, languageCode);

}
