import 'package:flutter/material.dart';

Color getColorByStatus({String? status}) {
  if (status?.toLowerCase() == "Awaiting Packing".toLowerCase()) {
    return Colors.yellow;
  } else if (status?.toLowerCase() == "Started Packing".toLowerCase()) {
    return Colors.blue;
  } else if (status?.toLowerCase() == "On Hold".toLowerCase()) {
    return Colors.orange;
  } else if (status?.toLowerCase() == "Ready Delivery".toLowerCase()) {
    return Colors.green;
  } else if (status?.toLowerCase() == "Canceled".toLowerCase()) {
    return Colors.red;
  } else {
    return Colors.blue;
  }
}


