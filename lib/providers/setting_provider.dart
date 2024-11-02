import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDark = false;
  String _languageCode = 'en'; // Default language

  bool get isDark => _isDark;
  String get languageCode => _languageCode;

  late SharedPreferences storage;

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    primaryColorLight: Colors.white,
  );

  // Custom light theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorLight: Colors.black,
  );

  // Initialize provider
  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark") ?? false;
    _languageCode = storage.getString("languageCode") ?? 'en';
    notifyListeners();
  }

  // Change theme
  void changeTheme() {
    _isDark = !_isDark;
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  // Change language
  void changeLanguage(String language) {
    _languageCode = language;
    storage.setString("languageCode", _languageCode);
    notifyListeners();
  }
}
