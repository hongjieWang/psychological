import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/style.dart';

///咨询管理-我的
class ConsultingMinePage extends StatefulWidget {
  @override
  _ConsultingMinePageState createState() => _ConsultingMinePageState();
}

class _ConsultingMinePageState extends State<ConsultingMinePage> {
  Map data = Get.arguments;
  Map wallet = {};
  @override
  void initState() {
    super.initState();
    ApiService().getWalletInfo().then((value) => setState(() {
          print(value);
          wallet = value['data'] != null ? value['data'] : {};
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: Get.height,
        child: Stack(
          children: [
            Positioned(
                child: Image.asset(
              ImageUtils.getImgPath("mine_bg3x"),
              height: 300,
              fit: BoxFit.cover,
            )),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text('个人中心'),
                centerTitle: true,
              ),
              body: _body(),
            )
          ],
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _imageBg(),
          _lable(),
          SizedBox(
            height: 30.sp,
          ),
          _meuns()
        ],
      ),
    );
  }

  ///用户可体现金额
  Widget _lable() {
    return Container(
      height: 120.h,
      margin: EdgeInsets.fromLTRB(40.sp, 0.sp, 40.sp, 0.sp),
      padding: EdgeInsets.fromLTRB(50.sp, 20.sp, 50.sp, 20.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("可提现金额（元）", style: labelStyle()),
            Text(
              "${wallet['noWithdraw'] != null ? wallet['noWithdraw'] : 0}",
              style: TextStyle(
                  color: StyleUtils.fontColor_3,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("累计收益（元）", style: labelStyle()),
            Text(
                "${wallet['accumulatedEarnings'] != null ? wallet['accumulatedEarnings'] : 0}",
                style: TextStyle(
                    color: StyleUtils.fontColor_3,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w500)),
          ],
        )
      ]),
    );
  }

  ///咨询管理菜单
  Widget _meuns() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 30.sp, 30.sp, 30.sp),
      margin: EdgeInsets.fromLTRB(40.sp, 10.sp, 40.sp, 10.sp),
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
      ),
      child: Column(
        children: [
          _itemRow('sz', '咨询设置', _consultingSetPage),
          Divider(),
          _itemRow('consult3x', '咨询记录', _consultingRecordsPage),
          Divider(),
          _itemRow('settlement3x', '结算中心', _settlementCenterPage),
          Divider(),
          _itemRow('kf', '咨询客服', _ke),
          Divider(),
          _itemRow('mine3x', '个人信息', _personalInfoPage)
        ],
      ),
    );
  }

  /// 横向icon
  Widget _itemRow(String imgName, String title, Function function) {
    return Padding(
        padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
        child: InkWell(
          onTap: () {
            function();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ImageUtils.getImgPath(imgName)),
                  Padding(
                    padding: EdgeInsets.only(left: 30.sp),
                    child: Text(title),
                  )
                ],
              ),
              Icon(
                Icons.chevron_right_outlined,
                size: 60.sp,
                color: Colors.black45,
              )
            ],
          ),
        ));
  }

  ///用户头像信息
  Widget _imageBg() {
    return Container(
      width: 750.w,
      child: _head(),
    );
  }

  ///头像名称手机号等信息
  Widget _head() {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.sp, 50.sp, 50.sp, 40.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(25)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  data['members']['avatar'],
                  width: 108.r,
                  height: 108.r,
                )),
            Container(
              height: 90.sp,
              padding: EdgeInsets.only(left: 30.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['members']['membersName'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(data['members']['phone'],
                      style: TextStyle(
                        color: Color(0xFFF1F1F1),
                        fontSize: 24.sp,
                      )),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  TextStyle labelStyle() {
    return TextStyle(color: Color(0xFF969CA5), fontSize: 24.sp);
  }

  ///跳转咨询设置
  void _consultingSetPage() {
    ApiService().getConsultTiemService("${data['counselorId']}").then((value) =>
        {Get.toNamed(RouteConfig.consultingSetPage, arguments: value['data'])});
  }

  ///跳转结算中心
  void _settlementCenterPage() {
    Get.toNamed(RouteConfig.settlementCenterPage, arguments: wallet);
  }

  ///跳转咨询师个人信息页面
  void _personalInfoPage() {
    Get.toNamed(RouteConfig.personalInfoPage, arguments: data);
  }

  void _ke() {
    Get.toNamed(RouteConfig.customerPage);
  }

  void _consultingRecordsPage() {
    Get.toNamed(RouteConfig.consultingRecordsPage);
  }
}
