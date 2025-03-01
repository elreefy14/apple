import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastColor { success, error, warning, info }

void customShowToast({
  required String message,
  required ToastColor toastColor,
  Color textColor = Colors.white,
  ToastGravity gravity = ToastGravity.BOTTOM,
  double fontSize = 16.0,
  int toastDuration = 1, // Duration in seconds
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastDuration == 1 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: toastDuration,
    backgroundColor: switch (toastColor) {
      ToastColor.success => Colors.green,
      ToastColor.error => Colors.red,
      ToastColor.warning => Colors.yellow,
      ToastColor.info => Colors.blue
    },
    textColor: textColor,
    fontSize: fontSize,
  );
}
