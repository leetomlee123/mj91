import 'dart:async';
import 'package:mj91/common/values/values.dart';
import 'package:mj91/global.dart';
import 'package:mj91/utils/utils.dart';
import 'package:get/get.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = LoacalStorage().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 删除缓存token
Future deleteAuthentication() async {
  await LoacalStorage().remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = null;
}

/// 重新登录
void deleteTokenAndReLogin() async {
  await deleteAuthentication();
  Get.offAndToNamed('/login');
}
