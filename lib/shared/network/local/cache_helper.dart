import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants.dart';

class CacheHelper {
  
  // save them mode state
  static Future<void> saveMode(bool mode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(isDark, mode);
  }

  // get them mode state
  static Future<bool> getMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final value = sharedPreferences.getBool(isDark);
    if (value != null) {
      return value;
    } else {
      return false;
    }
  }
}
