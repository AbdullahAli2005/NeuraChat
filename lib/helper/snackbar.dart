import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_loading.dart';

class SnackbarService {
  // Info
  static void info(String msg) {
    Get.snackbar('Info', msg,
        backgroundColor: Colors.blue.withOpacity(.7), colorText: Colors.white);
  }

// Success
  static void success(String msg) {
    Get.snackbar('Success', msg,
        backgroundColor: Colors.green.withOpacity(.7), colorText: Colors.white);
  }

// Error
  static void error(String msg) {
    Get.snackbar('Error', msg,
        backgroundColor: Colors.redAccent.withOpacity(.7),
        colorText: Colors.white);
  }

  // Loading Dialog
  static void showLoadingDialog() {
    Get.dialog(const Center(child: CustomLoading()));
  }
}
