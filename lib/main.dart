import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/screens/splash_screen.dart';

import 'controllers/theme_controller.dart';
import 'helper/pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Pref.initialize(); // Initialize Hive
  Get.put(ThemeController()); // Inject ThemeController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeuraChat',
          themeMode: ThemeMode.system,
      // Light
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
        ),
      ),
      // Dark
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          // elevation: 2,
          // color: Colors.black87,
          centerTitle: true,
          titleTextStyle: TextStyle(
            // color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(
              // color: Colors.blue,
              ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  //light text color
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;

  //button color
  Color get buttonColor => brightness == Brightness.dark
      ? Colors.blue.withOpacity(0.6)
      : const Color.fromARGB(255, 117, 187, 245);
}
