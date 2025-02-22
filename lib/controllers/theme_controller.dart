import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/pref.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = Pref.defaultTheme.obs;

  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
      Pref.isDarkMode = false;
    } else {
      themeMode.value = ThemeMode.dark;
      Pref.isDarkMode = true;
    }
    Get.changeThemeMode(themeMode.value);
  }
}
