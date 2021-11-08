import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mj91/components/card_title.dart';
import 'package:readmore/readmore.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'movie_detail_controller.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                controller.movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: controller.movieDetailModel == null
                ? Container()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          card_title(
                            'Introduce',
                            _buildHead(),
                          ),
                          card_title(
                            " Paradise Falls",
                            _buildDesc(),
                          ),
                          card_title(
                            'Play online',
                            _buildItems(),
                          ),
                          card_title(
                              'Video screenshot', _buildMovieHShortPics()),
                        ],
                      ),
                    ),
                  ),
          );
        },
        init: MovieDetailController());
  }

  Widget _buildHead() {
    var headHeight = 160.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: headHeight,
        child: Row(
          children: [
            ExtendedImage.network(
              controller.movieDetailModel?.cover ?? "",
              width: 140,
              height: headHeight,
              // fit: BoxFit.fitHeight,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Text(controller.movieDetailModel?.intro ?? ""),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDesc() {
    log(controller.movieDetailModel?.desc!.trim() ?? "");
    return ReadMoreText(
      controller.movieDetailModel?.desc ?? "",
      trimLines: 2,
      style: TextStyle(color: Colors.black),
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'more',
      trimExpandedText: 'less',
    );
  }

  Widget _buildItems() {
    return WaterfallFlow.builder(
      shrinkWrap: true,
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (c, i) {
        var item = controller.movieDetailModel!.items![i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1.5, color: Colors.blue),
                  borderRadius: BorderRadius.circular(6),
                ),
              )),
              onPressed: () => controller.play(i),
              child: Text(item.name?.trim() ?? "")),
        );
      },
      itemCount: controller.movieDetailModel!.items!.length,
    );
  }

  Widget _buildMovieHShortPics() {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (c, i) {
          var e = controller.movieDetailModel!.pics![i];
          return ExtendedImage.network(
            e,
            width: 200,
            fit: BoxFit.fitWidth,
          );
        },
        itemCount: controller.movieDetailModel!.pics!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
