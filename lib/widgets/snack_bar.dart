import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void showCustomSnackBar({
    required String text,
    required Color color,
    Color colorText = Colors.white,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: color.withOpacity(.6),
        messageText: Center(
          child: CustomText(
            text: "$text!",
            color: colorText,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
