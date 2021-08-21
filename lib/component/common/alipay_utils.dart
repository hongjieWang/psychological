import 'package:get/get.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:tobias/tobias.dart';

///支付宝支付工具类
///{resultStatus: 9000, result: {"alipay_trade_app_pay_response":
///{"code":"10000","msg":"Success","app_id":"2021002150657287",
///"auth_app_id":"2021002150657287","charset":"UTF-8","timestamp":"2021-06-23 15:51:31",
///"out_trade_no":"DJ-605104640035524608","total_amount":"0.01",
///"trade_no":"2021062322001489071423986494","seller_id":"2088141685277906"},
///"sign":"CsgQE5WuipBIfO2D2It/1lSDWHD2AVhOenoyPKSz0VrDbytq/U+t1hl23a9OW0GNYeVShQazH4kb1/JcyNRY1bfsor+uLIOxCstK2bwOTF7RS4KuxPeSHshzJNnuTPIMWhaLyOPXrv3Br6n0j1AB4PQ0TlS0t3gIfrRF2kDHqgIMISsYOW6BpAcQX3kzICE1/mK/y5qcJ/5PDJrtCf0t4UaPkT0qRiijoO1X4cSkCu0zQ28/ZYCB54ICmP4zzoiJJvJiEmKQtG/aGudZRVrdN9TxYvV+2BxsB6zQi50l6AxZbkuD/3ijLVQCMx4RLO7+cLcv0BU37n0di6Ngn4/3/Q==","sign_type":"RSA2"}, memo: ,
///extendInfo: {"doNotExit":true,"isDisplayResult":true}}
class AliPayUtils {
  static aliPays(value) async {
    aliPayVersion().then((value) => print(value));
    aliPay(value).then((value) => {
          print(value),
          if (value['resultStatus'] == "9000")
            {Get.offAllNamed(RouteConfig.paySuccessPage)}
          else
            {Get.offNamed(RouteConfig.payFailPage)}
        });
  }

  static Future<bool> isAliPayInstalled() async {
    return await isAliPayInstalled();
  }

  ///支付上下文
  static Map content = {};

  ///设置上下文
  static setContent(Map content) {
    AliPayUtils.content = content;
  }
}
