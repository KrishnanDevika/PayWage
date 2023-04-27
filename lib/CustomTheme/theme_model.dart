import 'package:flutter/foundation.dart';
import 'package:paywage/CustomTheme/theme_preferences.dart';

class ThemeModel extends ChangeNotifier{
  bool? _isDark;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark {
    if(_isDark != null) {
      return _isDark!;
    }
    return false;

  }

  ThemeModel(){
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }

  getPreferences() async{
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  set isDark(bool value){
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }


}