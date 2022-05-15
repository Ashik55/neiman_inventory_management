import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CProgressBar extends StatelessWidget {
  Color? color;
  double? size;

  CProgressBar({this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: size ?? 25.0,
            width: size ?? 25.0,
            child: Platform.isIOS
                ? const CupertinoActivityIndicator()
                : CircularProgressIndicator(
                    color: color,
                  )));
  }
}
