import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  late SharedPreferences _sharedPrefs;

  SharedPrefs._internal();
  static SharedPrefs get instance => _instance;

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }
  Future<void> setStringData(String key, String value) async {
    await _sharedPrefs.setString(key, value);
  }

  String getStringData(String key) {
    return _sharedPrefs.getString(key) ?? "";
  }

  Future<void> setBoolData(String key, bool value) async {
    await _sharedPrefs.setBool(key, value);
  }

  bool getBoolData(String key) {
    return _sharedPrefs.getBool(key) ?? false;
  }

  
}
