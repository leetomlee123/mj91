import 'package:mj91/pages/movie/movie_model.dart';
import 'package:mj91/pages/movie_detail/movie_detail_model.dart';
import 'package:mj91/pages/movie_player/movie_player_model.dart';
import 'package:mj91/pages/movie_search/movie_search_model.dart';
import 'package:mj91/utils/utils.dart';

/// 用户
class MovieApi {
  /// 首页
  static Future<List<List<MovieModel>>> index() async {
    var response = await Request().get('/index');
    List data = response;
    return data
        .map((e) => (e as List).map((e1) => MovieModel.fromJson(e1)).toList())
        .toList();
  }

//movie detail
  static Future<MovieDetailModel> movieDetail(var key) async {
    var response = await Request().get('/movies/$key');
    var data = response;
    return MovieDetailModel.fromJson(data);
  }

  //play movie
  static Future<PlayMovieModel> playMovie(var key) async {
    var response = await Request().get('/movies/tv/$key');
    var data = response;
    return PlayMovieModel.fromJson(data);
  }

  //search movie
  static Future<List<MovieModel>> searchMovie(var key, int page) async {
    var response = await Request().get('/movies/$key/search/$page/tv');
    List data = response;
    return data.map((e) => MovieModel.fromJson(e)).toList();
  }
}
