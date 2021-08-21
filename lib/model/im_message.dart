import 'package:standard_app/model/proto/message.pb.dart';
import 'package:standard_app/model/proto/reply_body.pb.dart';

class ImMessage {
  ///消息类型
  int type;

  /// 文字消息
  MessageProto message;

  ///绑定消息
  ReplyBodyProto reply;

  Map tojson() => {'type': type, 'message': message, 'reply': reply};
}
