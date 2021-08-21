import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/page/mine/order/order_state.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/Toasts.dart';

class OrderController extends GetxController {
  final state = OrderState();
  final TextEditingController evaluationContentController =
      new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();

  onTab(index) {
    print('change---> $index');
  }

  ///点击调整订单详情
  onClickItme(item) {
    state.orderItme.value = item;
    Get.toNamed(RouteConfig.orderDetailsPage);
  }

  ///用户点击退款
  onClickDrawback(item) async {
    state.drawbackItem.value = item;
    var result = await Get.toNamed(RouteConfig.drawbackPage);
    return result;
  }

  ///
  getFuncByStatus(item) async {
    if (item['orderStatus'] == 1) {
      return await onClickDrawback(item);
    } else if (item['orderStatus'] == 3) {
      Toasts.show("订单退款中，请耐心等待...");
    } else if (item['orderStatus'] == 0) {
      onFuncOnceAgainToBuy(item);
    }
  }

  ///再次购买点击事件
  onFuncOnceAgainToBuy(item) {
    ApiService()
        .getCounselorInfoService("${item['combo']['counselorId']}")
        .then((value) => Get.toNamed(RouteConfig.appointmentPayPage,
                arguments: {
                  "order": item,
                  "combo": item['combo'],
                  "item": value['data']
                }));
  }

  ///申请退款
  applyRefund() {
    Map data = {
      "orderNo": state.drawbackItem['orderNo'],
      "refundReasonId": state.pursueReason['payRefundApplyTypeId'],
      "refundUserId": Global.getUserId(),
      "membersId": state.drawbackItem['combo']['counselorId'],
      "refundInstructions": evaluationContentController.text,
      "phone": phoneController.text
    };
    if (_check()) {
      ApiService().payRefundApply(data).then((value) => {
            Toasts.show("退款申请成功，请您耐心等待"),
            state.pursueBtnName.value = "退款中",
            Get.back(result: "ok")
          });
    }
  }

  ///检查退款参数信息
  bool _check() {
    if (state.pursueReason['payRefundApplyTypeId'] == null ||
        state.pursueReason['payRefundApplyTypeId'] == -1) {
      Toasts.show("退款原因不能为空");
      return false;
    }
    if (evaluationContentController.text == '') {
      Toasts.show("申请说明不能为空");
      return false;
    }
    return true;
  }

  /// 点击订单进入订单详情
  onClickTime(item) {
    print("点击了$item");
  }
}
