import 'package:shared_preferences/shared_preferences.dart';

class SharePreference {
  static const _isOpened = 'is_open';

  static Future<void> setNotFirstOpen() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isOpened, false);
  }
  static Future<bool> getFirstOpen() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isOpened) ?? true;
  }

}