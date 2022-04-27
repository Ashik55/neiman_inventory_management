import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'constants.dart';

showMessageSnackbar(
    {required String? message,
    SnackPosition? snackPosition,
    Duration? duration,
    Color? backgroundColor}) {
  // if(backgroundColor != Colors.red || !kReleaseMode){
    Get.showSnackbar(GetSnackBar(
      message: message,
      backgroundColor: backgroundColor ?? Colors.blueGrey,
      duration: duration ?? const Duration(milliseconds: 2000),
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
    ));
  // }

}




// showMessageToast(
//     {required String? message,
//     Toast? toastLength,
//     ToastGravity? toastGravity,
//     Color? backgroundColor,
//     Color? textColor}) {
//
//
//   Fluttertoast.cancel();
//
//   Fluttertoast.showToast(
//       msg: "$message",
//       toastLength: toastLength ?? Toast.LENGTH_SHORT,
//       gravity: toastGravity ?? ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: backgroundColor ?? Colors.grey.shade200,
//       textColor: textColor ?? Colors.black,
//       fontSize: 14.0);
// }
