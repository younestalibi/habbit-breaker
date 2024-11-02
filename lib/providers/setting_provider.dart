import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDark = false;
  String _languageCode = 'en';

  bool get isDark => _isDark;
  String get languageCode => _languageCode;

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
    _isDark = SharedPrefs.instance.getBoolData('isDark') ?? false;
    _languageCode =
        SharedPrefs.instance.getStringData('languageCode').isNotEmpty
            ? SharedPrefs.instance.getStringData('languageCode')
            : 'en';
    notifyListeners();
  }

  // Change theme
  void changeTheme() {
    _isDark = !_isDark;
    SharedPrefs.instance.setBoolData("isDark", _isDark);
    notifyListeners();
  }

  // Change language
  void changeLanguage(String language) async {
    _languageCode = language;
    SharedPrefs.instance.setStringData("languageCode", _languageCode);
    await S.load(Locale(languageCode));

    notifyListeners();
  }
}
