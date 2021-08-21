import 'package:get/get.dart';

class AppointmentState {
  RxInt count;
  RxString title;
  RxList selectedTime;

  ///预约时间
  RxString appointmentTime;

  ///咨询人电话
  RxString phone;

  ///咨询人年龄段
  RxString age;

  ///咨询人性别
  RxInt sex;

  RxList labelData;

  /// 点击填写
  RxString problemLabel;

  ///问题类型
  RxList problemType;

  ///问题描述内容
  RxString problemDescription;

  ///支付方式 1:微信,2:支付宝
  RxInt payWay;

  ///是否安装了微信
  RxBool installWx;

  ///是否安装了支付宝
  RxBool installAlipay;

  ///咨询方式
  RxInt way;

  //课程信息
  RxMap combo;

  ///咨询师信息
  RxMap counselorInfo;

  /// 用户协议
  RxBool userAgreement;

  ///预约信息
  RxMap customerRelationship;

  ///订单信息
  RxMap order;

  AppointmentState() {
    count = 0.obs;
    title = "咨询师姓名".obs;
    selectedTime = [].obs;
    appointmentTime = "".obs;
    phone = ''.obs;
    age = ''.obs;
    sex = 0.obs;
    problemDescription = ''.obs;
    problemType = [].obs;
    labelData = [].obs;
    payWay = 0.obs;
    way = 0.obs;
    counselorInfo = {}.obs;
    userAgreement = false.obs;
    installWx = true.obs;
    installAlipay = true.obs;
    customerRelationship = {}.obs;
    combo = {}.obs;
    problemLabel = "点击填写".obs;
    order = {}.obs;
  }
}
