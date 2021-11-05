import 'package:extended_image/extended_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mj91/components/my_fijkplayer_skin.dart';
import 'package:mj91/utils/screen_device.dart';

import 'movie_player_controller.dart';

class MoviePlayerPage extends GetView<MoviePlayerController> {
  MoviePlayerPage({Key? key}) : super(key: key);
  var widthPic;

  @override
  Widget build(BuildContext context) {

    widthPic = getDeviceWidth(context) / 2.5;
    return GetBuilder(
      builder: (builder) {
        return controller.playMovieModel == null
            ? Container()
            : ExtendedNestedScrollView(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _buildItems(),
                      ),
                      _buildLike()
                    ],
                  ),
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [_buildPlayer()];
                },
              );
      },
      init: MoviePlayerController(),
    );
  }

  Widget _buildPlayer() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.black,
      toolbarHeight: 290 - kToolbarHeight,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: FijkView(
          height: 290,
          color: Colors.black,
          fit: FijkFit.cover,
          player: controller.player,
          panelBuilder: (
            FijkPlayer player,
            FijkData data,
            BuildContext context,
            Size viewSize,
            Rect texturePos,
          ) {
            /// 使用自定义的布局
            return CustomFijkPanel(
              player: player,
              // 传递 context 用于左上角返回箭头关闭当前页面，不要传递错误 context，
              // 如果要点击箭头关闭当前的页面，那必须传递当前组件的根 context
              pageContent: context,
              viewSize: viewSize,
              texturePos: texturePos,
              curActiveIdx: controller.index.value,
              // 显示的配置
              showConfig: controller.vCfg,
              // json格式化后的视频数据
              videos: controller.movieDetailController!.movieDetailModel!.items,
            );
          },
        ),
      ),
    );
  }

  Widget _buildItems() {
    List<Widget> wds = [];
    var items = controller.items;
    for (var i = 0; i < items!.length; i++) {
      var item = items[i];
      wds.add(Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                controller.index == i ? Colors.red : Colors.blue),
          ),
          onPressed: () {
            // 切换播放源
            controller.changeCurPlayVideo(i);
          },
          child: Text(
            item.name!.trim(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return Center(
        child: Wrap(
      children: wds,
      runSpacing: 5,
      spacing: 5,
    ));
  }

  Widget _buildLike() {
    List<Widget> wds = [];
    var everyUpdate = controller.playMovieModel!.likes;
    for (var i = 0; i < everyUpdate!.length; i++) {
      var e = everyUpdate[i];
      wds.add(GestureDetector(
        onTap: () {
          controller.movieDetailController!.initData(e.id);
          Get.offNamed("/movie/detail", arguments: {"name": e.name});
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  ExtendedImage.network(
                    e.cover ?? "",
                    width: widthPic,
                    fit: BoxFit.fitWidth,
                    height: widthPic * .6,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        ' ${e.name ?? ""}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ));
    }
    return Wrap(
      spacing: 20,
      children: wds,
    );
  }
}
