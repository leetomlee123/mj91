import 'package:mj91/pages/Index/Index_view.dart';
import 'package:mj91/pages/home/home.binding.dart';
import 'package:mj91/pages/home/home_view.dart';
import 'package:mj91/pages/login/login_binding.dart';
import 'package:mj91/pages/login/login_view.dart';
import 'package:mj91/pages/movie/movie_binding.dart';
import 'package:mj91/pages/movie/movie_view.dart';
import 'package:mj91/pages/movie_detail/movie_detail_binding.dart';
import 'package:mj91/pages/movie_detail/movie_detail_view.dart';
import 'package:mj91/pages/movie_player/movie_player_binding.dart';
import 'package:mj91/pages/movie_player/movie_player_view.dart';
import 'package:mj91/pages/notfound/notfound_view.dart';
import 'package:mj91/pages/proxy/proxy_view.dart';
import 'package:mj91/pages/shelf/shelf_binding.dart';
import 'package:mj91/pages/shelf/shelf_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Index;

  static final routes = [
    GetPage(
      name: AppRoutes.Index,
      page: () => IndexPage(),
    ),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.Home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.Shelf,
      page: () => ShelfPage(),
      binding: ShelfBinding(),
    ),
    GetPage(
        name: AppRoutes.Movie,
        page: () => MoviePage(),
        binding: MovieBinding(),
        children: [
          GetPage(
              name: AppRoutes.MovieDetail,
              page: () => MovieDetailPage(),
              binding: MovieDetailBinding(),
              children: [
                GetPage(
                  name: AppRoutes.MoviePlayer,
                  page: () => MoviePlayerPage(),
                  binding: MoviePlayerBinding(),
                ),
              ]),
        ]),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => NotfoundPage(),
  );

  static final proxyRoute = GetPage(
    name: AppRoutes.Proxy,
    page: () => ProxyPage(),
  );
}
