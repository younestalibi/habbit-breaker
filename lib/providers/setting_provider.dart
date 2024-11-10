import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDark = false;
  String _languageCode = 'en';
  bool _dailyNotifications = false;

  bool get isDark => _isDark;
  String get languageCode => _languageCode;
  bool get dailyNotifications => _dailyNotifications;

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    primaryColorLight: Colors.white,
  );

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorLight: Colors.black,
  );

  Future<void> init() async {
    _isDark = SharedPrefs.instance.getBoolData('isDark');
    _dailyNotifications =
        SharedPrefs.instance.getBoolData('dailyNotifications');
    _languageCode =
        SharedPrefs.instance.getStringData('languageCode').isNotEmpty
            ? SharedPrefs.instance.getStringData('languageCode')
            : 'en';
    notifyListeners();
  }

  void enableDailyNotification() {
    _dailyNotifications = !_dailyNotifications;
    SharedPrefs.instance.setBoolData("dailyNotifications", _dailyNotifications);
    notifyListeners();
  }

  void changeTheme() {
    _isDark = !_isDark;
    SharedPrefs.instance.setBoolData("isDark", _isDark);
    notifyListeners();
  }

  void changeLanguage(String language) async {
    _languageCode = language;
    SharedPrefs.instance.setStringData("languageCode", _languageCode);
    await S.load(Locale(languageCode));
    notifyListeners();
  }

  void resetDailyNotification() async {
    _dailyNotifications = false;
    SharedPrefs.instance.setBoolData("dailyNotifications", _dailyNotifications);
    notifyListeners();
  }
}
