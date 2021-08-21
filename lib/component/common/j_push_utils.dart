import 'dart:math';

import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';

class JPushUtils {
  JPushUtils._privateConstructor() {
    initJpush();
  }

  static final JPushUtils _instance = JPushUtils._privateConstructor();

  static JPushUtils get instance {
    return _instance;
  }

  static JPush jpush = new JPush();

  static initJpush() async {
    // 初始化

    // 获取注册的ID
    jpush.getRegistrationID().then((rid) {
      print("获取注册的id:$rid");
    });
    // 初始化
    jpush.setup(
      // 极光官方申请应用的APP KEY
      appKey: "b2ad5bc63c9ef188382836b6",
      channel: "ios",
      production: true,
      debug: false,
    );
    bind();
    // iOS10+ 可以通过此方法来设置推送是否前台展示，是否触发声音，是否设置应用角标 badge
    // jpush.applyPushAuthority(
    //     new NotificationSettingsIOS(sound: true, alert: true, badge: true));
    try {
      // 监听消息通知
      jpush.addEventHandler(
        // 接收通知回调方法。
        onReceiveNotification: (Map<String, dynamic> message) async {
          // print("flutter onReceiveNotification: $message");
        },
        // 点击通知回调方法。
        onOpenNotification: (Map<String, dynamic> message) async {
          // 当用户点击时，可以做一些路由跳转
          print("flutter onOpenNotification: $message");
          jpush.setBadge(0);
        },
        // 接收自定义消息回调方法。
        onReceiveMessage: (Map<String, dynamic> message) async {
          // print("flutter onReceiveMessage: $message");
        },
      );
    } catch (e) {
      print('极光SDK配置异常');
    }
  }

  static void bind() {
    ApiService().getUserInfo().then((value) => {
          if (value['code'] == Api.success)
            {
              // 设置别名实现指定用户推送R
              jpush
                  .setAlias(
                      value['data'] == null ? getNum() : value['data']['phone'])
                  .then((map) {
                print("设置别名成功");
                // jpush.applyPushAuthority(new NotificationSettingsIOS(
                //     sound: true, alert: true, badge: true));
              })
            }
          else
            {
              jpush.setAlias(getNum()).then((map) {
                print("设置别名成功");
              })
            }
        });
  }

  static String getNum() {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 10;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }
}
