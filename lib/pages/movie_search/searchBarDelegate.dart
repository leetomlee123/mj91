import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:mj91/pages/movie/movie_model.dart';
import 'package:mj91/router/app_pages.dart';
import 'package:mj91/services/movie.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class searchBarDelegate extends SearchDelegate<String> {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "搜索";
  int page = 0;
  bool isFinish = true;
  List<MovieModel> movies = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, "");
      },
    );
  }

  Widget headerImageItem(MovieModel movieModel, {double width = 200.0}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.Movie + AppRoutes.MovieDetail,
            arguments: {"key": movieModel.id, "name": movieModel.name ?? ""});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                ExtendedImage.network(
                  movieModel.cover ?? "",
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      ' ${movieModel.name ?? ""}',
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
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
        future: MovieApi.searchMovie(query, 1),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Container();
            // 当前没有连接到任何的异步任务
            case ConnectionState.waiting:
            // 连接到异步任务并等待进行交互
            case ConnectionState.active:
              print("--------->loading");
              return Container(
                child: Center(
                  child: Text("加载数据中..."),
                ),
              );
            // 连接到异步任务并开始交互
            case ConnectionState.done:
              print("--------->done");
              if (snapshot.hasError) {
                print("--------->error");
                return Container(
                  child: Center(
                    child: Text("加载数据失败"),
                  ),
                );
              } else if (snapshot.hasData) {
                movies = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: WaterfallFlow.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        collectGarbage: (List<int> garbages) {
                          garbages.forEach((index) {
                            final provider = ExtendedNetworkImageProvider(
                              movies[index].cover ?? '',
                            );
                            provider.evict();
                          });
                        },
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (itemBuilder, i) {
                        return headerImageItem(movies[i]);
                      }),
                );
              }
          }
          return Container();
        });

  }



  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }


}
