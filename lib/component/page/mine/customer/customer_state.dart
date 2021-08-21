import 'package:get/get.dart';

///客服管理数据驱动器
class CustomerState {
  RxMap user;

  RxList<Message> messages;
  CustomerState() {
    user = {}.obs;
    messages = [
      new Message(
          "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/avatar/erweima.png",
          false,
          "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/avatar/kf.png",
          "",
          "image"),
      new Message(
          "您还可以添加微信 wangxiaolong706 进行沟通",
          false,
          "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/avatar/kf.png",
          "",
          "text"),
      new Message(
          "您有问题可拨打15901402897 或 18232533068 电话及时帮您解决",
          false,
          "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/avatar/kf.png",
          "",
          "text"),
      new Message(
          "您好，这里是客服中心，请问有什么可以帮到您的",
          false,
          "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/avatar/kf.png",
          "",
          "text"),
    ].obs;
  }
}

///发送的信息类
class Message {
  String text; //内容
  String avatar; //头像
  bool isSender; //是否由自己发送
  String time;
  String type; //消息类型
  Message(this.text, this.isSender, this.avatar, this.time, this.type);
}
