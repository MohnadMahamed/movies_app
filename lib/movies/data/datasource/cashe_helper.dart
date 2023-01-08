import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await _sharedPreferences.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return _sharedPreferences.get(key);
  }
}
