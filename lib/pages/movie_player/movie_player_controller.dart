import 'package:fijkplayer/fijkplayer.dart';
import 'package:get/get.dart';
import 'package:mj91/components/my_fijkplayer_skin.dart';
import 'package:mj91/pages/movie_detail/movie_detail_controller.dart';
import 'package:mj91/pages/movie_detail/movie_detail_model.dart';
import 'package:mj91/pages/movie_player/movie_player_model.dart';
import 'package:mj91/services/movie.dart';
import 'package:wakelock/wakelock.dart';

class MoviePlayerController extends FullLifeCycleController with FullLifeCycle {
  final count = 0.obs;
  final FijkPlayer player = FijkPlayer();

  MovieDetailController? movieDetailController;
  List<Items>? items;
  var index = 0.obs;
  ShowConfigAbs vCfg = PlayerShowConfig();
  PlayMovieModel? playMovieModel;

  title() => items![index.value].name!.trim();

  @override
  void onInit() {
    super.onInit();
    speed = 1.0;
    player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.formatCategory, "reconnect", 1);
    player.setOption(
        FijkOption.playerCategory, "max-buffer-size", 10 * 1024 * 1024);
    player.setOption(FijkOption.formatCategory, "probesize", 1024 * 10);

    player.setOption(FijkOption.playerCategory, "min-frames", 100);
    // player.setOption(FijkOption.formatCategory, "headers", PLAYER_REQ_HEADERS);
    // player.onBufferPosUpdate.listen((v) {
    //   print(v);
    // });
    movieDetailController = Get.find<MovieDetailController>();
    index.value = Get.arguments['index'];
    items = movieDetailController?.movieDetailModel!.items;
    getVideoResourceUrl(index.value);
  }

  getVideoResourceUrl(var activeIdx) async {
    if (playMovieModel != null && activeIdx == index.value) return;
    index.value = activeIdx;

    var key = movieDetailController?.movieDetailModel!.items![activeIdx].id;
    playMovieModel = await MovieApi.playMovie(key);
    update();
  }

  // 切换播放源
  Future<void> changeCurPlayVideo(var activeIdx) async {
    await player.reset().then((_) async {
      await getVideoResourceUrl(activeIdx);
      String curTabActiveUrl = playMovieModel!.resource ?? "";
      player.setDataSource(
        curTabActiveUrl,
        autoPlay: true,
      );
    });
  }

  @override
  void onReady() {
    Wakelock.enable();
  }

  @override
  void onClose() {
    player.release();
    Wakelock.disable();
  }

  onChangeVideo(int curTabIdx, int curActiveIdx) {}

  increment() => count.value++;

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    player.pause();
  }

  @override
  void onResumed() {
    player.start();
  }
}

// 这里实现一个皮肤显示配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;
  @override
  bool nextBtn = true;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = true;
}
