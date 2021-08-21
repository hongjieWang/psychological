import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/address_picker/locations_data.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/page/mine/mine_controller.dart';
import 'package:standard_app/component/page/mine/mine_state.dart';
import 'package:standard_app/component/page/mine/setup/setup_controller.dart';
import 'package:standard_app/component/page/mine/setup/setup_state.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///个人中心
class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool isCounselor = false;
  final MineController logic = Get.put(MineController());
  final MineStats mineState = Get.find<MineController>().state;
  final SetupController setupLogic = Get.put(SetupController());
  final SetupState state = Get.find<SetupController>().state;

  @override
  void initState() {
    super.initState();
    if (Global.getUserId() != "0" && Global.getUserId() != "null") {
      ApiService().getUserInfo().then((value) => {
            if (value['code'] == Api.success)
              {
                setState(() {
                  state.name.value = value['data']['nickName'] == null
                      ? "未设置昵称"
                      : value['data']['nickName'];
                  state.introduction.value = value['data']['signature'] == null
                      ? ""
                      : value['data']['signature'];
                  state.sex.value = AppConstant.sexStr(value['data']['sex']);
                  state.birthdayStr.value = value['data']['birthday'] == null
                      ? ""
                      : value['data']['birthday'];
                  state.initProvince.value = value['data']['province'] != null
                      ? Address.getCityNameByCode(
                          provinceCode: value['data']['province'])[0]
                      : "";
                  state.initCity.value = value['data']['city'] != null
                      ? Address.getCityNameByCode(
                          provinceCode: value['data']['province'],
                          cityCode: value['data']['city'])[1]
                      : "";
                  state.phone.value = value['data']['phone'];
                  state.avatar.value = value['data']['avatar'];
                  state.professional.value = value['data']['industry'];
                  isCounselor = value['data']['memberIdentity'] == 2;
                  if (isCounselor) {
                    Global.setCounselorId("${value['data']['counselorId']}");
                  }
                  mineState.counselorId.value =
                      isCounselor ? "${Global.getCounselorId()}" : "0";
                })
              }
          });
    }
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
              height: 600.sp,
              width: double.infinity,
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

  ///个人中心入口页面
  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _imageBg(),
          _icon(),
          SizedBox(
            height: 20.sp,
          ),
          _rowIcon()
        ],
      ),
    );
  }

  Widget _imageBg() {
    return Container(
      child: _head(),
    );
  }

  ///头像名称手机号等信息
  Widget _head() {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.sp, 10.sp, 50.sp, 80.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                logic.onClickSettings();
              },
              child: Row(children: [
                Obx(() => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(30)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      state.avatar.value != null
                          ? state.avatar.value
                          : 'http://pub.julywhj.cn/%E5%A4%B4%E5%83%8F.jpeg',
                      width: 108.r,
                      height: 108.r,
                    ))),
                Container(
                  height: 120.sp,
                  padding: EdgeInsets.only(left: 30.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            state.name.value,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )),
                      Text(AppConstant.phoneDesensitization(state.phone.value),
                          style: TextStyle(
                            color: Color(0xFFF1F1F1),
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ])),
          TextButton(
              onPressed: () => {},
              child: Image.asset(
                ImageUtils.getImgPath("message3x_write"),
                width: 19,
                height: 19,
              ))
        ],
      ),
    );
  }

  ///icon入口
  Widget _icon() {
    return Container(
      width: double.infinity,
      height: 164,
      padding: EdgeInsets.fromLTRB(36.sp, 60.sp, 36.sp, 60.sp),
      margin: EdgeInsets.fromLTRB(30.sp, 0.sp, 30.sp, 0.sp),
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(2.0, 2.0), //阴影x轴偏移量
              blurRadius: 0, //阴影模糊程度
              spreadRadius: 0 //阴影扩散程度
              )
        ],
      ),
      child: Wrap(
        spacing: 80.sp, // 主轴(水平)方向间距
        runSpacing: 50.sp, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.spaceBetween, //沿主轴方向居中
        children: <Widget>[
          _item('dd', '我的订单', logic.onClickMyOrder),
          _item('gz', '我的关注', logic.onClickMyAttention),
          _item('yhj', '优惠券', logic.onClickMyCoupons),
          _item('zjrz', '专家入驻', logic.onClickExpert),
          Offstage(
            offstage: !isCounselor,
            child: _item('zigl', '咨询管理', logic.onClickCounsel),
          ),
        ],
      ),
    );
  }

  ///Icon
  Widget _item(String imgName, String title, Function function) {
    return InkWell(
        onTap: () {
          function();
        },
        child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Image.asset(
                  ImageUtils.getImgPath(imgName),
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Color(0xFF767676)),
                )
              ],
            )));
  }

  Widget _rowIcon() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 30.sp, 30.sp, 30.sp),
      margin: EdgeInsets.fromLTRB(30.sp, 30.sp, 30.sp, 30.sp),
      // width: 700.w,
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(2.0, 2.0), //阴影x轴偏移量
              blurRadius: 2, //阴影模糊程度
              spreadRadius: 0 //阴影扩散程度
              )
        ],
      ),
      child: Column(
        children: [
          _itemRow('fx', '分享', logic.onClickFenxiang),
          Divider(),
          _itemRow('kf', '联系客服', logic.onClickCustomerService),
          Divider(),
          _itemRow('fk', '意见反馈', logic.onClickFeedback),
          Divider(),
          _itemRow('sz', '设置', logic.onClickSettings)
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
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                    ),
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
}
