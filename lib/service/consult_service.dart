import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/http/dio_util.dart';

DioUtil _dio = new DioUtil();

Future<Map<String, dynamic>> consultList(int pageNum) async {
  return _dio.get(Api.CONSULT_API,
      pathParams: {'userId': Global.getUserId()},
      data: {'pageNum': pageNum, 'pageSize': '10'});
}

Future<Map<String, dynamic>> consultListAll(int pageNum) async {
  return _dio.get(Api.CONSULT_ALL_API,
      pathParams: {'userId': Global.getUserId()},
      data: {'pageNum': pageNum, 'pageSize': '10'});
}
