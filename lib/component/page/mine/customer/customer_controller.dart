import 'package:fixnum/fixnum.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/page/mine/customer/customer_state.dart';
import 'package:standard_app/model/im_message.dart';
import 'package:standard_app/model/proto/reply_body.pb.dart';
import 'package:standard_app/util/protobuf_util.dart';
import 'package:standard_app/util/time_utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

///客服管理控制器
class CustomerController extends GetxController {
  CustomerState state = CustomerState();

  ///链接是否打开
  static bool _connectionIsOpen = false;
  static bool _re = false;
  static WebSocketChannel channel;
  static int coonNum = 10;
  DateTime lastSendTime = null;

  @override
  void onInit() {
    _connection();
    ApiService()
        .getUserInfo()
        .then((value) => {state.user.value = value['data'], bing()});
    super.onInit();
  }

  _connection() {
    channel = IOWebSocketChannel.connect('ws://192.168.3.13:34567');
    channel.stream.listen(this.onData, onError: onError, onDone: onDone);
  }

  onDone() {
    print("服务端done");
    _connectionIsOpen = false;
    _re = false;
    reConnect();
  }

  onError(err) {
    print("出错");
    _connectionIsOpen = false;
    reConnect();
  }

  onData(onData) {
    print("链接监听");
    _connectionIsOpen = true;
    ImMessage message = ProtobufUtil.decode(onData);
    if (message.type == ProtobufUtil.MESSAGE) {
      state.messages.insert(
          0,
          Message(
              message.message.content,
              false,
              "http://pub.julywhj.cn/%E5%A4%B4%E5%83%8F.jpeg",
              timeFormatChineseHM(DateTime.now().toLocal()),
              "text"));
    }
  }

  ///重新链接 - 5s后重新链接
  void reConnect() {
    if (!_connectionIsOpen && !_re) {
      _re = true;
      if (coonNum > 10) {
        return;
      }
      Future.delayed(Duration(seconds: 10), () {
        print("reConnect-----------");
        coonNum++;
        this._connection();
        bing();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  void bing() {
    SentBodyProto send = SentBodyProto();
    send.key = "client_bind";
    send.timestamp = Int64(DateTime.now().millisecond);
    send.data.addAll({
      "account": state.user['phone'],
      "channel": Global.getPlatform(),
      "appVersion": "1.0.2",
      "osVersion": "1.0",
      "packageName": "",
      "deviceId": Global.getDeviceId()
    });
    // _webSocket.add(ProtobufUtil.encode(send));
    channel.sink.add(ProtobufUtil.encode(send));
  }

  sendMessage(String message) {
    String timeStr = "";
    if (lastSendTime == null) {
      lastSendTime = DateTime.now();
      timeStr = timeFormatChineseHM(DateTime.now().toLocal());
    } else {
      if (timeLessNum(lastSendTime) < -2 * 60) {
        lastSendTime = DateTime.now();
        timeStr = timeFormatChineseHM(DateTime.now().toLocal());
      }
    }
    state.messages.insert(
        0, Message(message, true, "${state.user['avatar']}", timeStr, "text"));
    Map data = {
      "title": "888",
      "action": "2",
      "content": "dnasdkasd你好",
      "receiver": "888888",
      "sender": "15600226523",
      "format": "text"
    };
    ApiService().sendMessage(data).then((value) => print(value));
  }
}
