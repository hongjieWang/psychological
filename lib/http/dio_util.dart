import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:standard_app/base/api.dart';

import 'auth_interceptor.dart';

class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class DioUtil {
  static BaseOptions _options = getDefOptions();
  static final DioUtil _instance = DioUtil._init();

  static Dio _dio;
  static bool mIsProxy = false;

  factory DioUtil() {
    return _instance;
  }

  DioUtil._init() {
    _dio = new Dio(_options);
    addInterceptors();
    //========== 配置抓包=======
    if (mIsProxy) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          // 这里改成自己电脑的IP
          return "PROXY 172.17.88.151:8888";
        };
        //抓Https包设置
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = 20 * 1000;
    options.receiveTimeout = 30 * 1000;
    options.baseUrl = Api.baseUrl;

    Map<String, dynamic> headers = Map<String, dynamic>();
    headers['Accept'] = 'application/json';

    String platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "IOS";
    }
    headers['OS'] = platform;
    options.headers = headers;
    options.responseType = ResponseType.plain;

    return options;
  }

  setOptions(BaseOptions options) {
    _options = options;
    _dio.options = _options;
  }

  addInterceptors() {
    _dio.interceptors.add(AuthInterceptor());
  }

  static addLock() {
    _dio.lock();
  }

  static unLock() {
    _dio.unlock();
  }

  Future<Map<String, dynamic>> get(String path,
      {pathParams, data, Function errorCallback}) {
    return request(path,
        method: Method.get,
        pathParams: pathParams,
        data: data,
        errorCallback: errorCallback);
  }

  Future<Map<String, dynamic>> delete(String path,
      {pathParams, data, Function errorCallback}) {
    return request(path,
        method: Method.delete,
        pathParams: pathParams,
        data: data,
        errorCallback: errorCallback);
  }

  Future<Map<String, dynamic>> post(String path,
      {pathParams, data, Function errorCallback}) {
    return request(path,
        method: Method.post,
        pathParams: pathParams,
        data: data,
        errorCallback: errorCallback);
  }

  Future<Map<String, dynamic>> request(String path,
      {String method, Map pathParams, data, Function errorCallback}) async {
    ///restful请求处理
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        if (path.indexOf(key) != -1) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }
    var queryParameters = Method.get == method ? data : null;
    Response response = await _dio.request(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(method: method));

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          return response.data;
        } else {
          return json.decode(response.data.toString());
        }
      } catch (e) {
        return null;
      }
    } else {
      _handleHttpError(response.statusCode);
      if (errorCallback != null) {
        errorCallback(response.statusCode);
      }
      return null;
    }
  }

  ///处理Http错误码
  void _handleHttpError(int errorCode) {}
}
