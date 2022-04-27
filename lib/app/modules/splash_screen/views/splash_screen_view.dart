import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../../components/custom_textwidget.dart';
import '../../components/load_image.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        builder: (controller) => Scaffold(
              backgroundColor: CustomColors.KPrimaryStatusBarColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: CustomColors.KPrimaryStatusBarColor,
                  elevation: 0,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: CAssetImage(imagePath: 'images/img_splash.png')),
                  const SizedBox(
                    height: 50,
                  ),
                  CText(
                    'Welcome In NeimanKosher',
                    fontSize: Dimens.textLargeDoubleExtra,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ));
  }
}
