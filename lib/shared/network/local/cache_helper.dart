import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants.dart';

class CacheHelper {
  /// save them mode state
  static Future<void> saveMode(
      {required bool mode, required SharedPreferences sharedPre}) async {
    // final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPre.setBool(isDark, mode);
  }

  /// get them mode state
  static Future<bool> getMode({required SharedPreferences sharedPref}) async {
    // final sharedPreferences = await SharedPreferences.getInstance();
    final value = sharedPref.getBool(isDark);
    if (value != null) {
      return value;
    } else {
      return false;
    }
  }
}
