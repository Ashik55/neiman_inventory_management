import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neiman_inventory/app/modules/base/base_view.dart';

import '../../../utils/dimens.dart';
import '../../../utils/utility.dart';
import '../../components/custom_textwidget.dart';
import '../../components/load_image.dart';
import '../../components/rounded_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LoginController>(
      builder: (controller) => BaseView(
        showLoading: controller.baseLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getOrientation(context) == Orientation.portrait
                  ? Dimens.basePaddingLarge
                  : getMaxWidth(context) * .08),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(child: CAssetImage(imagePath: 'images/img_login.png')),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: CText(
                  'Sign In',
                  fontSize: Dimens.textLargeDoubleExtra,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: controller.userNameController,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  // errorText: 'Error message',
                  border: OutlineInputBorder(),
                  // suffixIcon: Icon(
                  //   Icons.error,
                  // ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 1),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: CText(
                  "Remember me",
                  fontSize: Dimens.textRegular,
                ),
                activeColor: Colors.green,
                value: controller.rememberCheckbox,
                onChanged: (newValue) => controller.onRememberChange(newValue),
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CRoundedButton(
                    onClick: () => controller.onLoginClick(),
                    text: "Login",
                    backgroundColor: Colors.green,
                    width: getMaxWidth(context),
                    radius: Dimens.radiusNone),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
