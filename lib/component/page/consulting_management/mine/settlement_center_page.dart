import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///结算中心
class SettlementCenterPage extends StatefulWidget {
  @override
  _SettlementCenterPageState createState() => _SettlementCenterPageState();
}

class _SettlementCenterPageState extends State<SettlementCenterPage> {
  Map wallet = {};

  @override
  void initState() {
    super.initState();
    wallet = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("结算中心", icon: Icons.arrow_back_ios),
      body: _body(),
    );
  }

  ///我的钱包主体
  Widget _body() {
    return Container(
      decoration: BoxDecoration(color: StyleUtils.bgColor),
      child: Column(children: [_balance(), SizedBox(height: 80.sp), _list()]),
    );
  }

  ///钱包内容列表
  Widget _list() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.sp, 40.sp, 30.sp, 10.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.grey[300], width: 1.sp),
          borderRadius: BorderRadius.all(Radius.circular(20.0.sp))),
      child: Column(
        children: [
          InkWell(
              onTap: () => {_paymentDetails()},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(30.sp), child: Text("收支明细")),
                    Padding(
                        padding: EdgeInsets.only(right: 30.sp),
                        child: Icon(Icons.chevron_right))
                  ])),
          Divider(
            height: 0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(padding: EdgeInsets.all(30.sp), child: Text("提现记录")),
            Padding(
                padding: EdgeInsets.only(right: 30.sp),
                child: Icon(Icons.chevron_right)),
          ])
        ],
      ),
    );
  }

  Widget _balance() {
    return Container(
      color: StyleUtils.bgColor,
      child: Column(children: [
        SizedBox(
          height: 100.sp,
        ),
        Image.asset(
          ImageUtils.getImgPath("balance3x"),
          width: 110.r,
          height: 110.r,
        ),
        SizedBox(
          height: 70.sp,
        ),
        Text(
          "账户余额",
          style: TextStyle(fontSize: 32.sp, color: StyleUtils.fontColor_3),
        ),
        SizedBox(
          height: 22.sp,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "¥",
            style: TextStyle(fontSize: 32.sp),
          ),
          Text(
            "${wallet['accountBalance']}",
            style: TextStyle(
                fontSize: 60.sp,
                color: StyleUtils.fontColor_3,
                fontWeight: FontWeight.w500),
          ),
        ]),
        SizedBox(
          height: 124.sp,
        ),
        TextButton(
          onPressed: () {
            _withdrawPage();
          },
          child: Text(
            "提现",
            style: TextStyle(color: Colors.white, fontSize: 28.sp),
          ),
          style: ButtonStyle(
            //背景颜色
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              //默认不使用背景颜色
              return Color(0xFF3A8DFF);
            }),
            //设置按钮内边距
            padding: MaterialStateProperty.all(EdgeInsets.all(14.sp)),
            //设置按钮的大小
            minimumSize: MaterialStateProperty.all(Size(242.sp, 68.sp)),
            //外边框装饰 会覆盖 side 配置的样式
            shape: MaterialStateProperty.all(StadiumBorder()),
          ),
        )
      ]),
    );
  }

  ///提现按钮
  void _withdrawPage() {
    Get.toNamed(RouteConfig.withdrawPage, arguments: wallet);
  }

  ///收支明细
  void _paymentDetails() {
    Get.toNamed(RouteConfig.paymentRecordsPage, arguments: wallet);
  }
}
