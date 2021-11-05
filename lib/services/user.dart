import 'package:mj91/pages/login/login_model.dart';
import 'package:mj91/utils/utils.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserProfileModel> login({
    required Map params,
  }) async {
    var response = await Request().post(
      '/login',
      params: params,
    );
    return UserProfileModel.fromJson(response['data']);
  }
}
