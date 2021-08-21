import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/page/mine/order/order_controller.dart';
import 'package:standard_app/component/page/mine/order/order_state.dart';
import 'package:standard_app/util/style.dart';

///退款信息
class DrawbackPage extends StatelessWidget {
  final OrderController logic = Get.put(OrderController());
  final OrderState state = Get.find<OrderController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar('申请退款',
          icon: Icons.arrow_back_ios, openAction: true),
      body: _body(),
    );
  }

  /// 申请退款body页面
  Widget _body() {
    return SingleChildScrollView(
        child: Container(
      color: StyleUtils.bgColor,
      child: Column(
        children: [
          _drawback(),
          _drawbackNum(),
          _application(),
          _phone(),
          Padding(
              padding: EdgeInsets.only(top: 40.sp),
              child: TextButton(
                onPressed: () {
                  logic.applyRefund();
                },
                child: Text(
                  "提交申请",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  //外边框装饰 会覆盖 side 配置的样式
                  // shape: MaterialStateProperty.all(StadiumBorder()),
                  minimumSize: MaterialStateProperty.all(Size(686.sp, 68.sp)),
                  //背景颜色
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    //设置按下时的背景颜色
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue[200];
                    }
                    //默认不使用背景颜色
                    return Color(0xFF3A8DFF);
                  }),
                  padding: MaterialStateProperty.all(EdgeInsets.all(14.sp)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
              )),
          SizedBox(
            height: 100.sp,
          )
        ],
      ),
    ));
  }

  ///联系电话
  Widget _phone() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      ),
      height: 100.sp,
      margin: EdgeInsets.fromLTRB(32.sp, 0.sp, 32.sp, 0.sp),
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "联系电话",
            style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: StyleUtils.fontColor_3),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: logic.phoneController,
              decoration: InputDecoration(
                  hintText: "请填写咨询人电话",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: StyleUtils.fontColor_9, fontSize: 24.sp)),
            ),
          ))
        ],
      ),
    );
  }

  ///申请说明
  Widget _application() {
    return Container(
      width: 750.sp,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      ),
      margin: EdgeInsets.fromLTRB(32.sp, 20.sp, 32.sp, 20.sp),
      padding: EdgeInsets.only(left: 20.sp, top: 40.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("申请说明",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: StyleUtils.fontColor_3)),
          SizedBox(
            height: 20.sp,
          ),
          Card(
              color: Colors.grey[80],
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: logic.evaluationContentController,
                  maxLines: 10,
                  maxLength: 200,
                  decoration: InputDecoration.collapsed(
                      hintText: "必填，请详细填写申请说明~",
                      hintStyle: TextStyle(
                          color: StyleUtils.fontColor_9, fontSize: 22.sp)),
                ),
              )),
        ],
      ),
    );
  }

  ///退款金额
  Widget _drawbackMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "退款金额",
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: StyleUtils.fontColor_3),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: Text(
              "¥ ${state.drawbackItem['payPrice']}",
              style: StyleUtils.textStyle(
                  26.sp, StyleUtils.fontColor_9, FontWeight.normal),
            )),
      ],
    );
  }

  ///退款数量
  Widget _drawbackNum() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      ),
      height: 200.sp,
      margin: EdgeInsets.fromLTRB(32.sp, 0.sp, 32.sp, 0.sp),
      padding: EdgeInsets.fromLTRB(20.sp, 40.sp, 20.sp, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "退款数量",
                style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: StyleUtils.fontColor_3),
              ),
              Text(
                "x1",
                style: StyleUtils.textStyle(
                    26.sp, StyleUtils.fontColor_9, FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            height: 40.sp,
          ),
          _drawbackMoney()
        ],
      ),
    );
  }

  /// 退款原因
  Widget _drawback() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
      ),
      height: 120.sp,
      margin: EdgeInsets.fromLTRB(32.sp, 40.sp, 32.sp, 20.sp),
      child: Padding(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          child: InkWell(
            onTap: () {
              ApiService().getRefundTypeList().then((value) => {
                    print(value),
                    if (value['code'] == Api.success)
                      {Get.bottomSheet(_pursueReason(value['data']))}
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(
                    "申请原因",
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: StyleUtils.fontColor_3),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.sp),
                    child: Obx(() => Text(
                          state.pursueReason['refundTypeName'],
                          style: TextStyle(
                              color: StyleUtils.fontColor_3, fontSize: 30.sp),
                        )),
                  )
                ]),
                Icon(
                  Icons.chevron_right,
                  color: StyleUtils.fontColor_9,
                ),
              ],
            ),
          )),
    );
  }

  ///显示申请原因
  Widget _pursueReason(items) {
    return Container(
      height: 600.sp,
      width: 750.sp,
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(25.0.sp)),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 30.sp, bottom: 10.sp),
              child: Text(
                "请选择申请原因",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _item(items),
          )
        ],
      )),
    );
  }

  ///申请原因列表
  List<Widget> _item(items) {
    List<Widget> list = [];
    items.forEach((element) {
      list.add(Divider());
      list.add(InkWell(
          onTap: () {
            state.pursueReason.value = element;
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 30.sp, 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    element['refundTypeName'],
                    style: TextStyle(
                      fontSize: 30.sp,
                    ),
                  ),
                  Container(
                    width: 30.sp,
                    height: 30.sp,
                    decoration: BoxDecoration(
                      color:
                          state.pursueReason == element ? Colors.orange : null,
                      borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                      //设置四周边框
                      border: new Border.all(
                          width: 1,
                          color: state.pursueReason == element
                              ? Colors.orange
                              : Colors.grey),
                    ),
                  )
                ],
              ))));
    });
    return list;
  }
}
