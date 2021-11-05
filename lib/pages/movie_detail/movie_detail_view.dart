import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

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
                Get.arguments['name'] ?? "",
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
                          _itemScaffold(
                            'Introduce',
                            _buildHead(),
                          ),
                          _itemScaffold(
                            " Paradise Falls",
                            _buildDesc(),
                          ),
                          _itemScaffold(
                            'Play online',
                            _buildItems(),
                          ),
                          _itemScaffold(
                              'Video screenshot', _buildMovieHShortPics()),
                        ],
                      ),
                    ),
                  ),
          );
        },
        init: MovieDetailController());
  }

  Widget _itemScaffold(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            height: 30,
            child: Row(
              children: [
                VerticalDivider(
                  color: Colors.blue,
                  width: 10,
                  thickness: 6,
                  indent: 2,
                  endIndent: 2,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          child
        ],
      ),
    );
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
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 120,
        itemBuilder: (c, i) {
          var item = controller.movieDetailModel!.items![i];
          return Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.5,
                          color: controller.index.value == i
                              ? Colors.blue
                              : Color(0xFFB4B4B4),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )),
                    onPressed: () => controller.play(i),
                    child: Text(item.name?.trim() ?? "")),
              ));
        },
        itemCount: controller.movieDetailModel!.items!.length,
      ),
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
