import 'dart:typed_data';

import 'package:standard_app/model/im_message.dart';
import 'package:standard_app/model/proto/message.pb.dart';
import 'package:standard_app/model/proto/reply_body.pb.dart';

class ProtobufUtil {
  static String ACTION_999 = "999";
  static int DATA_HEADER_LENGTH = 1;

  static int MESSAGE = 2;
  static int REPLY_BODY = 4;

  ///弹框类处理器
  static String ACTION_ALERT = "3";

  /// 数据编码
  static List<int> encode(var content) {
    List<int> msg = content.writeToBuffer().buffer.asUint8List();
    return msg;
  }

  /// 数据解码
  static ImMessage decode(data) {
    Int8List int8Data = Int8List.fromList(data);
    Int8List contentTypeInt8Data = int8Data.sublist(0, DATA_HEADER_LENGTH);
    Int8List contentInt8Data =
        int8Data.sublist(DATA_HEADER_LENGTH, int8Data.length);
    int contentType = contentTypeInt8Data.elementAt(0);
    ImMessage message = ImMessage();
    message.type = contentType;
    switch (contentType) {
      case 2:
        message.message = MessageProto.fromBuffer(contentInt8Data);
        break;
      case 4:
        message.reply = ReplyBodyProto.fromBuffer(contentInt8Data);
        break;
    }
    return message;
  }
}
