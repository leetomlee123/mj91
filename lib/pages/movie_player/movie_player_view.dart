import 'package:extended_image/extended_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mj91/components/card_title.dart';
import 'package:mj91/components/my_fijkplayer_skin.dart';
import 'package:mj91/utils/screen_device.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'movie_player_controller.dart';

class MoviePlayerPage extends GetView<MoviePlayerController> {
  MoviePlayerPage({Key? key}) : super(key: key);
  var widthPic;

  @override
  Widget build(BuildContext context) {
    widthPic = getDeviceWidth(context) / 2.5;
    return GetBuilder(
      builder: (builder) {
        if (controller.playMovieModel == null) {
          return Container();
        } else {
          return ExtendedNestedScrollView(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildItems(),
                    card_title("EveryUpdate",
                        _buildMore(controller.playMovieModel!.everyUpdate)),
                    card_title(
                        "Likes", _buildMore(controller.playMovieModel!.likes))
                  ],
                ),
              ),
            ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [_buildPlayer()];
            },
          );
        }
      },
      init: MoviePlayerController(),
    );
  }

  Widget _buildPlayer() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.black,
      toolbarHeight: 310 - kToolbarHeight,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: FijkView(
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

    return WaterfallFlow.builder(
      shrinkWrap: true,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (c, i) {
        var item = controller.items![i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    controller.index.value == i ? Colors.red : Colors.blue),
              ),
              onPressed: () => controller.changeCurPlayVideo(i),
              child: Text(item.name?.trim() ?? "")),
        );
      },
      itemCount: controller.items!.length,
    );
  }

  Widget _buildMore(var data) {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (c, i) {
          var e = data[i];
          return GestureDetector(
            onTap: () {
              controller.movieDetailController!.initData(e.id);
              controller.movieDetailController!.movieName = e.name;

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
          );
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
