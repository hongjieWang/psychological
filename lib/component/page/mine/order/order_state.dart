import 'package:get/get.dart';

class OrderState {
  ///订单状态对应数据翻译
  Map orderStatusMap = {
    0: "待付款",
    1: "支付成功",
    2: "已取消",
    3: "退款中",
    5: "退款完成",
    4: "交易成功"
  };
  Map btnNameByStatus = {
    0: "去支付",
    1: "申请退款",
    2: "关闭订单",
    3: "退款中",
    4: "删除订单",
    5: "退款完成"
  };
  RxMap orderItme;
  RxMap drawbackItem;

  ///申请原因列表
  RxList<Map<String, String>> list;

  ///申请原因
  RxMap pursueReason;

  ///申请退款按钮
  RxString pursueBtnName;

  OrderState() {
    orderItme = {}.obs;
    drawbackItem = {}.obs;
    pursueBtnName = "申请退款".obs;
    pursueReason = {"refundTypeName": "请选择申请原因", "payRefundApplyTypeId": -1}.obs;
    list = [
      {"title": "咨询师不专业", "id": "01"},
      {"title": "想换个咨询师", "id": "02"},
      {"title": "不想咨询了", "id": "03"}
    ].obs;
  }
}
