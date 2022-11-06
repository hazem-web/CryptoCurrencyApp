import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme_Provider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;

  Future<void> saveThemeModetoSharePref(ThemeMode mode)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = 'System';
    switch(mode){
      case ThemeMode.system:
        themeMode = ThemeMode.system;
        theme = "System";
        break;
      case ThemeMode.dark:
        themeMode=ThemeMode.dark;
        theme="Dark";
        break;
      case ThemeMode.light:
        themeMode=ThemeMode.light;
        theme="Light";
        break;
    }
    notifyListeners();
    prefs.setString("thememode", theme);
  }

  void getThemeModeFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeModeString = prefs.getString("thememode");
    if (themeModeString == "System") {
      themeMode = ThemeMode.system;
    } else if (themeModeString == "Light") {
      themeMode = ThemeMode.light;
    } else if (themeModeString == "Dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }
    notifyListeners();
    }
}