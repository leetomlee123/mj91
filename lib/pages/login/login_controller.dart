import 'package:flutter/material.dart';
import 'package:mj91/global.dart';
import 'package:mj91/pages/login/login_model.dart';
import 'package:mj91/services/services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  login() async {
    var user = userNameController.text;
    var pass = passwordController.text;
    if (user.isNotEmpty || pass.isNotEmpty) {
      // Get.snackbar("警告", "用户名或密码不可为空");
      // return;
      print("login work");
      UserProfileModel userProfileModel =
          await UserAPI.login(params: {"user": user, "password": pass});
      Global.saveProfile(userProfileModel);
      Global.profile = userProfileModel;
    }
  }
}
