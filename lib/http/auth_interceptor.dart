import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/http/dio_util.dart';
import 'package:standard_app/routes/routes.dart';

///登录拦截器
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Global.getToken() == null || Global.getToken() == "null") {
      Global.setToken(Global.getDeviceId());
      DioUtil.addLock();
      ApiService().anonynouslogin();
      DioUtil.unLock();
    }
    options.headers["Authorization"] =
        AppConstant.TOKEN_PREFIX + Global.getToken();
    options.headers["DeviceId"] = Global.getDeviceId();
    return super.onRequest(options, handler);
  }

  @override
  // ignore: missing_return
  Future onResponse(Response response, ResponseInterceptorHandler handler) {
    print("请求返回状态码:[${response.statusCode}]");
    Map responseData = jsonDecode(response.data);
    if (responseData['code'] == 401) {
      DioUtil.addLock();
      ApiService().anonynouslogin();
      DioUtil.unLock();
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.message);
    Get.toNamed(RouteConfig.noWifiPage);
    super.onError(err, handler);
  }
}
