import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  void setTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (theme == 'Light') {
      currentTheme.value = ThemeMode.light;
      prefs.setString('theme', 'Light');
    } else if (theme == 'Dark') {
      currentTheme.value = ThemeMode.dark;
      prefs.setString('theme', 'Dark');
    } else {
      currentTheme.value = ThemeMode.system;
      prefs.setString('theme', 'System');
    }
    Get.changeThemeMode(currentTheme.value);
  }
}