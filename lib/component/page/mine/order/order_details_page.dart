import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/common/alipay_utils.dart';
import 'package:standard_app/component/common/select_datetime.dart';
import 'package:standard_app/component/common/wechat_utils.dart';
import 'package:standard_app/component/page/mine/order/order_controller.dart';
import 'package:standard_app/component/page/mine/order/order_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/time_data.dart';

///订单详情
class OrderDetailsPage extends StatelessWidget {
  final OrderController logic = Get.put(OrderController());
  final OrderState state = Get
      .find<OrderController>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: StyleUtils.buildAppBar("订单详情", icon: Icons.arrow_back_ios),
        body: _body(),
      ),
    );
  }

  ///订单详情页面
  Widget _body() {
    print(state.orderItme.toJson());
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: StyleUtils.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              _statusAndBtn(),
              _consultation(),
              Divider(),
              _orderDetails(),
            ],
          ),
          _showMoney(state.orderItme['payPrice'])
        ],
      ),
    );
  }

  ///订单状态和按钮
  Widget _statusAndBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 40.sp),
      child: Column(
        children: [
      Text(
      state.orderStatusMap[state.orderItme['orderStatus']],
        style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w500,
            color: StyleUtils.fontColor_3),
      ),
      Offstage(
          offstage: state.orderItme['orderStatus'] != 0 && !isShowOneBtn(state.orderItme),
          child: TextButton(
          onPressed: () => {logic.getFuncByStatus(state.orderItme)},
      child: Text(
        state.btnNameByStatus[state.orderItme['orderStatus']],
        style: StyleUtils.textStyle(
            22.sp, Colors.white, FontWeight.normal),
      ),
      style: ButtonStyle(
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //设置按下时的背景颜色
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          //默认不使用背景颜色
          return Color(0xFF80ADEA);
        }),
        //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(150.sp, 44.sp)),
        //设置边框
        padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    ))]
    ,
    )
    ,
    );
  }

  bool isShowOneBtn(item) {
    if (item['customerRelationships'] != null) {
      return item['customerRelationships'][0]['status'] ==
          AppConstant.APPOINTMENT_NO ||
          item['customerRelationships'][0]['status'] == AppConstant.CANCEL;
    }
    return false;
  }

  ///咨询师信息
  Widget _consultation() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.fromLTRB(32.sp, 20.sp, 32.sp, 20.sp),
      child: Column(
        children: [
          _text('咨询师', state.orderItme['orderName']),
          _text('咨询方式', state.orderItme['combo']['comboName']),
          _text('咨询次数', 'x1'),
          _text('咨询${state.orderItme['combo']['courseDuration']}分钟',
              '¥${state.orderItme['payPrice']}元/次'),
          _text('咨询状态', '待咨询'),
          _text('咨询时间',
              '${state.orderItme['customerRelationships'] == null
                  ? ""
                  : name()}'),
        ],
      ),
    );
  }

  String name() {
    return state.orderItme['customerRelationships'][0]['nextTime'] == null
        ? ""
        : state.orderItme['customerRelationships'][0]['nextTime'];
  }

  ///订单详情
  Widget _orderDetails() {
    print(state.orderItme['orderStatus'] == 0);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.fromLTRB(32.sp, 20.sp, 32.sp, 20.sp),
      child: Column(
        children: [
          _orderText("订单编号：", "${state.orderItme['orderNo']}"),
          _orderText("下单时间：", "${state.orderItme['createTime']}"),
          Offstage(
            offstage: state.orderItme['orderStatus'] != 0,
            child: _orderText("关闭时间：", "${state.orderItme['closeOrderTime']}"),
          ),
          _orderText("支付时间：",
              "${state.orderItme['paymentTime'] == null ? "" : state
                  .orderItme['paymentTime']}"),
          _orderText("支付方式：", AppConstant.getPay(state.orderItme['payWay'])),
        ],
      ),
    );
  }

  Widget _orderText(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(40.sp, 10.sp, 40.sp, 10.sp),
          child: Text(
            title,
            style: StyleUtils.textStyle(
                26.sp, StyleUtils.fontColor_9, FontWeight.normal),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(40.sp, 10.sp, 40.sp, 10.sp),
          child: Text(
            value,
            style: StyleUtils.textStyle(
                26.sp, StyleUtils.fontColor_3, FontWeight.normal),
          ),
        )
      ],
    );
  }

  ///咨询师详情格式
  Widget _text(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(46.sp, 40.sp, 40.sp, 10.sp),
          child: Text(
            title,
            style: StyleUtils.textStyle(
                24.sp, StyleUtils.fontColor_3, FontWeight.normal),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(40.sp, 40.sp, 46.sp, 10.sp),
          child: Text(
            value,
            style: StyleUtils.textStyle(
                24.sp, StyleUtils.fontColor_6, FontWeight.normal),
          ),
        )
      ],
    );
  }

  ///咨询师详情格式
  Widget _appointmentTime(String title, List<String> value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(40.sp, 10.sp, 40.sp, 10.sp),
          child: Text(title),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: forEachAppointmentTime(value),
        )
      ],
    );
  }

  List<Widget> forEachAppointmentTime(List<String> items) {
    List<Widget> list = [];
    items.forEach((element) {
      list.add(InkWell(
          onTap: () {
            print('去预约');
            Get.bottomSheet(new SelectDateTime(
                title: "预约时段",
                dateList: date,
                selected: [],
                onClickFun: logic.onClickTime));
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(40.sp, 10.sp, 40.sp, 10.sp),
              child: Text(element))));
    });
    return list;
  }

  ///实际付款显示
  Widget _showMoney(double num) {
    return Padding(
        padding: EdgeInsets.only(right: 40.sp, top: 40.sp),
        child: Text.rich(TextSpan(children: [
          TextSpan(
              text: "实付：",
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
          TextSpan(
              text: "$num",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: "元",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold))
        ])));
  }

  void pay() {
    ApiService().payOrderPayment(state.orderItme).then((value) =>
    {
      if (value['code'] == Api.success)
        {
          if (state.orderItme['payWay'] == AppConstant.alipay)
            {AliPayUtils.aliPays(value['data'])}
          else
            {WeChatUtils().toWxPay(value['data'])}
        }
    });
  }
}
