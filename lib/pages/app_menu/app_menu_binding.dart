import 'package:get/get.dart';
import 'app_menu_controller.dart';

class AppMenuBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<AppMenuController>(() => AppMenuController());
    }
}
