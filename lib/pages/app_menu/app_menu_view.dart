import 'package:flutter/material.dart';
import 'package:mj91/global.dart';
import 'package:mj91/router/app_pages.dart';
import 'package:get/get.dart';

import 'app_menu_controller.dart';

class AppMenuPage extends GetView<AppMenuController> {
  const AppMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 200.0),
        child: _buildUserHead(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [_buildUserHead()],
        ),
      ),
    );
  }

  Widget _buildUserHead() {
    return Global.isOfflineLogin
        ? UserAccountsDrawerHeader(
            accountEmail: Text(Global.profile?.email ?? ''),
            accountName: Text(Global.profile?.username ?? ''),
          )
        : Container(
            child: TextButton(
              child: Text("登录"),
              onPressed: () => Get.toNamed(AppRoutes.Login),
            ),
          );
  }
}
