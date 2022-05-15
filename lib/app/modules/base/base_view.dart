// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


import '../../utils/utility.dart';
import '../components/progress_bar.dart';


class BaseView extends StatelessWidget {
  Widget child;
  bool showLoading = false;

  BaseView({required this.child, required this.showLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showLoading)
          Container(
            height: getMaxHeight(context),
            width: getMaxWidth(context),
            color: Colors.white54,
            child: CProgressBar(),
          )
      ],
    );
  }
}
