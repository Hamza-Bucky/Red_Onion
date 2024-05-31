import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyDialogs {
  static success({required String prompt}) {
    Get.snackbar('Success', prompt,
        colorText: Color.fromRGBO(255, 255, 255, 0.9),
        backgroundColor: Color.fromRGBO(0, 255, 0, 0.7));
  }

  static error({required String prompt}) {
    Get.snackbar('error', prompt,
        colorText: Color.fromRGBO(255, 255, 255, 0.9),
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7));
  }

  /* static showProgress() {
    Get.dialog(Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    ));
  }*/

  static info({required String prompt}) {
    Get.snackbar('info', prompt, colorText: Color.fromRGBO(255, 255, 255, 0.9));
  }
}
