import 'dart:developer';

import 'package:get/get.dart';
import 'package:mj91/pages/movie_detail/movie_detail_model.dart';
import 'package:mj91/router/app_pages.dart';
import 'package:mj91/services/movie.dart';

class MovieDetailController extends GetxController {
  final count = 0.obs;
  var index = (-1).obs;
  MovieDetailModel? movieDetailModel;

  @override
  void onInit() {
    super.onInit();
    var key = Get.arguments['key'];

    initData(key);
  }

  void initData(key) {
    MovieApi.movieDetail(key).then((value) {
      movieDetailModel = value;
      update();
    });
  }

  @override
  void onReady() {
    log("ready");
  }

  @override
  void onClose() {}

  void play(var i) {
    index.value = i;
    Get.toNamed(AppRoutes.Movie + AppRoutes.MovieDetail + AppRoutes.MoviePlayer,
        arguments: {"index": i});
  }

  increment() => count.value++;
}
