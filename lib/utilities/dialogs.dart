import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackbar(String title, String message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 10),
      mainButton: TextButton(
        child: const Text("關閉"),
        onPressed: () {
          Get.back();
        },
      ));
}
