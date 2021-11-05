import 'package:get/get.dart';
import 'movie_player_controller.dart';

class MoviePlayerBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<MoviePlayerController>(() => MoviePlayerController());
    }
}
