import 'package:flutter/material.dart';
import 'package:mj91/pages/app_menu/app_menu_view.dart';
import 'package:mj91/pages/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert_sharp),
              onPressed: () {},
            )
          ],
          centerTitle: true,
          title: Text("书架"),
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState!.openDrawer()),
        ),
        drawer: Drawer(
          child: AppMenuPage(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ));
  }
}
