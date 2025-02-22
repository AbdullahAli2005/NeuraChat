import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// class Pref {
//   static late Box _box;

//   static Future<void> initialize() async {
//     // // for initializing hive to use app directory
//     // Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
//     // _box = Hive.box(name: 'myData');
//   }

//   static bool get isDarkMode => _box.get('isDarkMode') ?? false;
//   static set isDarkMode(bool v) => _box.put('isDarkMode', v);

//   static ThemeMode get defaultTheme {
//     final data = _box.get('isDarkMode');
//     log('data: $data');
//     if (data == null) return ThemeMode.system;
//     if (data == true) return ThemeMode.dark;
//     return ThemeMode.light;
//   }
// }


import 'package:path_provider/path_provider.dart';

class Pref {
  static late Box _box;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox('myData'); // Open the Hive box
  }

  static bool get isDarkMode => _box.get('isDarkMode', defaultValue: false);
  
  static set isDarkMode(bool value) {
    _box.put('isDarkMode', value);
    log("Theme Updated: ${value ? "Dark" : "Light"}");
  }

  static ThemeMode get defaultTheme {
    final data = _box.get('isDarkMode');
    log('Current Theme in Hive: $data');
    return data == true ? ThemeMode.dark : ThemeMode.light;
  }
}

