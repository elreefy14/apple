import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedPreferences? sharedPreferences;

  static sharedInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> set({
    required dynamic key,
    required dynamic value,
  }) async {
    if (value is int) {
      await sharedPreferences?.setInt(key, value);
    } else if (value is double) {
      await sharedPreferences?.setDouble(key, value);
    } else if (value is bool) {
      await sharedPreferences?.setBool(key, value);
    } else if (value is String) {
      await sharedPreferences?.setString(key, value);
    } else if (value is List<String>) {
      await sharedPreferences?.setStringList(key, value);
    }
  }

  static get({required dynamic key}) {
    return sharedPreferences?.get(key);
  }

  static remove({required String key})async {
    await sharedPreferences?.remove(key);
  }

  static clear()async {
    await sharedPreferences?.clear();
  }

}