import 'package:flutter/material.dart';
import 'package:mj91/pages/Index/Index_controller.dart';
import 'package:mj91/pages/movie/movie_view.dart';
import 'package:mj91/pages/splash/spalsh_view.dart';
import 'package:get/get.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body:
            controller.isloadWelcomePage.isTrue ? SplashPage() : MoviePage()));
  }
}
