import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:neiman_inventory/app/data/local_storage/local_storage.dart';
import 'dart:math';
import 'dart:developer' as DEV;
import 'constants.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
const _chars_text = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getRandomTextString({required int length}) =>
    String.fromCharCodes(Iterable.generate(length,
        (_) => _chars_text.codeUnitAt(_rnd.nextInt(_chars_text.length))));

int getRandomNumber({int? length}) => _rnd.nextInt(length ?? 5500000);

String getFormattedDate(String? date) {
  print(date);
  return DateFormat("MM/dd/yy").format(DateTime.parse('$date')).toString();
}

String? setDate() {
  return DateFormat("yyyy-MM-dd HH:MM:ss").format(DateTime.now());
}

bool isUnder6Month(String? date) {
  print("isUnder6Month : $date");
  final currentDate = DateTime.now();
  final orderedDate = DateTime.parse("$date");
  int difference = currentDate.difference(orderedDate).inDays;

  print("currentDate $currentDate");
  print("orderedDate $orderedDate");
  print("difference $difference");

  return difference < 180;
}

String? getTodaysDate() {
  return DateFormat("yyyy-MM-dd").format(DateTime.now());
}

String? getFirstDayOfCurrentMonth() {
  String month = (DateTime.now().month).toString();
  if (month.length == 1) {
    month = "0$month";
  }
  return "${DateTime.now().year}-$month-01";
}

String? get6MonthAgoDate() {
  return DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(const Duration(days: 180)));
}

Future<bool> isInternetAvailable() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

String getShortImageUrl(String? imageId) {
  String url = imageBaseUrl + "?entryPoint=image&size=small&id=$imageId";
  if (kDebugMode) {
    print(url);
  }
  return url;
}

String getBasicAuth() {
  LocalStorage localStorage = Get.find();
  return 'Basic ' + base64Encode(utf8.encode(
      '${localStorage.getUserName()}:${localStorage.getPassword()}'));
}

String getRegularImageUrl(String? imageId) {
  return imageBaseUrl + "?entryPoint=image&id=$imageId";
}

printObject({required Object? data,String? title}) {
  try{
    DEV.log("${title ?? "data"} ===> ");
    DEV.log(json.encode(data));
  }on Exception catch(e) {
    if (kDebugMode) {
      print(e);
    }
  }

}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

bool checkIfNumberIsValid({required String? number}) {
  if (number != null && number.isNotEmpty) {
    if (number.length == 11) {
      if (number[0] == '0' && number[1] == '1') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}

showMaterialDatePicker(BuildContext context, {String? midDivider}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101));
  if (picked != null) {
    String divider = midDivider ?? "/";
    return "${picked.day}$divider${picked.month}$divider${picked.year}";
  }
}

showDOBPicker(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now());

  if (pickedDate != null) {
    //"1996-01-10",
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    return formattedDate;
  }
}

getMaxWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getMaxHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Orientation getOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation;
}

// hideKeyboard(context) {
//   FocusScope.of(context).unfocus();
// }

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

getSimpleFraction({required String? value, int? fractionDigit}) {
  num x = num.parse("$value");
  int defaultFractionDigit = isInteger(x) ? 0 : 2;
  return x.toStringAsFixed(fractionDigit ?? defaultFractionDigit);
}

bool isInteger(num value) => value is int || value == value.roundToDouble();

bool isListNullOrEmpty(List<dynamic>? list) {
  if (list == null) {
    return true;
  } else if (list.isEmpty) {
    return true;
  } else {
    return false;
  }
}

extension Extension on Object {
  bool isNullOrEmpty() => this == [];
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
