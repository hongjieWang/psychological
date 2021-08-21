import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/alipay_utils.dart';
import 'package:standard_app/component/common/wechat_utils.dart';
import 'package:standard_app/component/page/index_page.dart';
import 'package:standard_app/http/dio_util.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/toasts.dart';
import 'appointment_state.dart';

///预约控制器
class AppointmentController extends GetxController {
  final state = AppointmentState();
  DioUtil _dio = DioUtil();
  TextEditingController phoneController = new TextEditingController();
  var _map;

  AppointmentController() {
    WeChatUtils().installFluwx().then((value) => state.installWx.value = value);
    AliPayUtils.isAliPayInstalled()
        .then((value) => state.installAlipay.value = value);
  }

  ///build加载数据
  void init() {
    _map = Get.arguments;
    state.combo.value = _map['combo'];
    state.counselorInfo.value = _map['item'];
    state.order.value = _map['order']; // 从订单过来重新购买和去支付的数据
  }

  ///自增
  void increase() {
    ++state.count;
  }

  ///申请预约
  void applyAnAppointment() {
    if (_check()) {
      Map data = {
        "age": state.age.value,
        "crId": state.customerRelationship['crId'],
        "sex": state.sex.value,
        "phone": phoneController.text,
        "nextTime": state.appointmentTime.value,
        "problemType": labelIdsToStr(),
        "problemDesc": state.problemDescription.value
      };
      showLoading2();
      _dio
          .post(Api.COUNSELOR_APPOINTMENT_API,
              data: data, errorCallback: errorCallback)
          .then((value) => {
                if (value['code'] == Api.success)
                  {
                    Get.offAll(IndexPage(
                      currentIndex: 1,
                    ))
                  }
                else
                  {print(value), Toasts.show("网络异常,请稍后重试..."), Get.back()}
              });
    }
  }

  void errorCallback(status) {
    print(status);
  }

  ///问题描述
  void problemDescriptionSubmit() {
    Get.back(result: "ok");
  }

  bool _check() {
    if (state.appointmentTime.value == '') {
      Toasts.show('请选择预约时间...');
      return false;
    }
    if (state.age.value == '') {
      Toasts.show('请选择年龄信息...');
      return false;
    }
    if (state.sex.value == 0) {
      Toasts.show('请选择性别...');
      return false;
    }
    if (phoneController.text == '') {
      Toasts.show('请输入联系方式...');
      return false;
    }
    return true;
  }

  ///点击支付按钮触发支付事件
  void pay() {
    if (state.combo.isEmpty) {
      Toasts.show("请选择咨询方式");
      return;
    }
    if (state.payWay.value == 0) {
      Toasts.show("请选择支付方式");
      return;
    }
    if (!state.userAgreement.value) {
      Toasts.show("请勾选咨询协议");
      return;
    }
    showLoading2();

    String orderNo = "";
    if (state.order.value != null) {
      orderNo = state.order['orderNo'];
    }
    _dio.post(Api.ORDER_API, data: {
      "orderName": "咨询师-${_map['item']['members']['membersName']}",
      "membersId": Global.getUserId(),
      "comboId": state.combo['comboId'],
      "serviceNumber": 1,
      "couponsId": state.counselorInfo['counselorId'],
      "payWay": state.payWay.value,
      "platform": Global.getPlatform(),
      "deviceId": Global.getDeviceId(),
      "orderNo": orderNo
    }).then((value) => {print("去支付：$value"), payStatus(value)});
  }

  ///支付异步回调处理
  void payStatus(obj) {
    Get.back();
    if (obj['code'] == Api.success) {
      if (state.payWay.value == AppConstant.weChatPay) {
        WeChatUtils().setContent(
            {"combo": state.combo, "counselorInfo": state.counselorInfo});
        WeChatUtils().toWxPay(obj['data']);
      } else if (state.payWay.value == AppConstant.alipay) {
        AliPayUtils.setContent(
            {"combo": state.combo, "counselorInfo": state.counselorInfo});
        AliPayUtils.aliPays(obj['data']);
      }
    } else {
      Toasts.show("网络异常,请稍后重试...");
      Get.back();
    }
  }

  String labelIdsToStr() {
    if (state.problemType.length != 0) {
      String ids = "";
      state.problemType.forEach((element) {
        ids = ids + element + ",";
      });
      return ids.substring(0, ids.length - 1);
    }
    return "";
  }
}
