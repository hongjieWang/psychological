import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:fluwx/fluwx.dart';

import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/routes/routes.dart';

class WeChatUtils {
  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static final WeChatUtils _instance = WeChatUtils._internal();

  //提供了一个工厂方法来获取该类的实例
  factory WeChatUtils() {
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  WeChatUtils._internal() {
    // 初始化
    init();
  }

  ///支付上下文
  Map content = {};

  ///设置上下文
  setContent(Map content) {
    this.content = content;
  }

  void init() {
    _initFluwx();
    fluwx.weChatResponseEventHandler.listen((event) async {
      print("微信状态码：${event.errCode}");
      print("微信状态码：${event.errStr}");
      if (event is fluwx.WeChatAuthResponse) {
        print("微信授权${event.code}");
        ApiService().weCharlogin(event.code);
      }
      if (event is fluwx.WeChatShareResponse) {
        print("微信分享$event");
      }
      if (event is fluwx.WeChatPaymentResponse) {
        print("微信支付$event");
        // 支付成功
        if (event.errCode == 0) {
          print("支付成功");
          Get.offNamed(RouteConfig.paySuccessPage);
        } else {
          ///支付失败页面
          Get.offNamed(RouteConfig.payFailPage, arguments: content);
        }
      }
    });
  }

  _initFluwx() async {
    await registerWxApi(
        appId: "wx6c4a80348ab8de66",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://706xinli.com/apple-app-site-association/");
  }

  Future<bool> installFluwx() async {
    return await fluwx.isWeChatInstalled;
  }

  void weChatLogin() {
    print("微信登录");
    fluwx
        .sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
        .then((data) {
      print("data login $data");
    }).catchError((e) {
      print('weChatLogin  e  $e');
    });
  }

  ///分享
  void shareToWeChat(model) {
    fluwx.shareToWeChat(model);
  }

  ///微信支付
  void toWxPay(payInfo) async {
    var result = await isWeChatInstalled;
    if (result) {
      fluwx
          .payWithWeChat(
              appId: payInfo['appId'],
              partnerId: payInfo['partnerId'],
              prepayId: payInfo['prepayId'],
              packageValue: payInfo['packageValue'],
              nonceStr: payInfo['nonceStr'],
              timeStamp: int.parse(payInfo['timeStamp']),
              sign: payInfo['sign'])
          .then((data) {
        print("支付申请：$data");
      });
    }
  }
}
