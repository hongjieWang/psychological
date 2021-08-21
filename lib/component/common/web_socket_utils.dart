import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/model/im_message.dart';
import 'package:standard_app/model/proto/reply_body.pb.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/protobuf_util.dart';
import 'package:fixnum/fixnum.dart';

class WebSocketService {
  WebSocketService._init() {
    WebSocket.connect('ws://192.168.3.13:34567').then((webSocket) => {
          _webSocket = webSocket,
          webSocket.listen((onData) {
            ImMessage message = ProtobufUtil.decode(onData);
            if (message.type == ProtobufUtil.MESSAGE) {
              String action = message.message.getField(2);
              if (action == ProtobufUtil.ACTION_ALERT) {
                _alert(
                    message.message.getField(7), message.message.getField(3));
              }
            }
          }, onError: (err) {}, onDone: () {}),
          bing()
        });
  }
  //保存单例
  static WebSocketService _singleton = WebSocketService._init();

  //工厂构造函数
  factory WebSocketService() => _singleton;

  static WebSocket _webSocket;

  static final WebSocketService ws = new WebSocketService();

  void bing() {
    SentBodyProto send = SentBodyProto();
    send.key = "client_bind";
    send.timestamp = Int64(DateTime.now().millisecond);
    send.data.addAll({
      "account": Global.getPhone(),
      "channel": Global.getPlatform(),
      "appVersion": "1.0.2",
      "osVersion": "1.0",
      "packageName": "",
      "deviceId": Global.getDeviceId()
    });
    _webSocket.add(ProtobufUtil.encode(send));
  }

  ///弹框处理
  void _alert(String title, String content) {
    print("title:$title content:$content");
    showCustomDialog<bool>(
      context: Get.context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("确定"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
