import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/common/avatar.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/common/h5_web_view.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_controller.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_state.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentPayPage extends StatefulWidget {
  @override
  _AppointmentPayPageState createState() => _AppointmentPayPageState();
}

class _AppointmentPayPageState extends State<AppointmentPayPage> {
  final AppointmentController logic = Get.put(AppointmentController());
  final AppointmentState state = Get.find<AppointmentController>().state;
  final TapGestureRecognizer _registProtocolRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyProtocolRecognizer =
      TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    logic.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("购买服务",
          icon: Icons.arrow_back_ios,
          openAction: true,
          content: "确定取消购买咨询服务？",
          items: ['残忍离开', '继续购买'],
          okFun: () {}, errorAction: () {
        Get.back();
      }),
      body: _body(),
    );
  }

  ///购买服务详情页面
  Widget _body() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: StyleUtils.bgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          Expanded(
              // 这个页面是要滑动的，所以用Expanded
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _content(),
                SizedBox(height: 30.sp),
                _pay(),
                Text("支付完成后，再预约咨询时间。",
                    style: TextStyle(fontSize: 10, color: Color(0xFF999999))),
              ],
            ),
          )),
          _payBtn()
        ],
      ),
    );
  }

  ///标题
  Widget _title() {
    return Padding(
        padding: EdgeInsets.fromLTRB(32.sp, 26.sp, 0.sp, 0.sp),
        child: Text(
          "预约信息",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }

  ///预约购买详细信息
  Widget _content() {
    return Container(
      height: 636.sp,
      margin: EdgeInsets.fromLTRB(32.sp, 56.sp, 32.sp, 0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          //圆角
          Radius.circular(10.0.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.only(left: 40.sp),
              child: Text(
                "预约老师",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40.sp),
              child: Row(children: [
                Avatar(
                  url: state.counselorInfo['members']['avatar'],
                  width: 46,
                  height: 46,
                  padding: EdgeInsets.zero,
                  onTapFun: (item) {
                    print(item);
                  },
                  item: state.counselorInfo,
                ),
                Text(
                  "${state.counselorInfo['members']['membersName']}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666)),
                )
              ]),
            )
          ]), //预约老师
          Divider(
            height: 1,
            color: Color(0xFFE7E7E7),
          ),
          Padding(
              padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("咨询方式",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333))),
                  _showPopupMenuButton(Row(children: [
                    Text(
                      state.combo.isEmpty ? "请选择" : state.combo['comboName'],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666)),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 14.sp),
                      height: 40.sp,
                      child: Image.asset(
                        ImageUtils.getImgPath("below3x"),
                        width: 14.sp,
                        height: 14.sp,
                      ),
                    )
                  ])),
                ],
              )),
          Divider(
            height: 1,
            color: Color(0xFFE7E7E7),
          ), //咨询方式
          Padding(
              padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("咨询次数",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333))),
                  Text("1次",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666)))
                ],
              )), //咨询次数
          Divider(
            height: 1,
            color: Color(0xFFE7E7E7),
          ),
          Padding(
              padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "视频咨询 ${state.combo.isEmpty ? "0" : state.combo['courseDuration']}分钟",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333))),
                    Text(
                        "¥ ${state.combo.isEmpty ? "0" : state.combo['originalPrice']} 元/次",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666))),
                  ])),
          Divider(
            height: 1,
            color: Color(0xFFE7E7E7),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.sp, right: 40.sp, bottom: 20.sp),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("咨询优惠",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333))),
                  Text("暂无",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666)))
                ]),
          )
        ],
      ),
    );
  }

  ///支付信息
  Widget _pay() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.sp, 10.sp, 40.sp, 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          //圆角
          Radius.circular(5.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Offstage(
              offstage: !state.installWx.value,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageUtils.getImgPath("weixin"),
                            width: 42.sp,
                            height: 36.sp,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.sp),
                            child: Text(
                              "微信支付",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF333333)),
                            ),
                          ),
                        ],
                      ),
                    ), //微信支付
                    Radio(
                      value: AppConstant.weChatPay,
                      groupValue: state.payWay.value,
                      onChanged: (value) {
                        DataStatistics.instance
                            .event("wechar_pay", {"num": ""});
                        setState(() {
                          state.payWay.value = value;
                        });
                      },
                    ),
                  ]))),
          Obx(() => Offstage(
              offstage: !state.installAlipay.value,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageUtils.getImgPath("zhifubao"),
                            width: 40.sp,
                            height: 40.sp,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.sp),
                              child: Text(
                                "支付宝",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF333333)),
                              )),
                        ],
                      ),
                    ), //支付宝支付
                    Radio(
                      value: AppConstant.alipay,
                      groupValue: state.payWay.value,
                      onChanged: (value) {
                        DataStatistics.instance.event("ali_pay", {"num": ""});
                        setState(() {
                          state.payWay.value = value;
                        });
                      },
                    ),
                  ])))
        ],
      ),
    );
  }

  /// 支付按钮及其用户协议
  Widget _payBtn() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20.sp,
                ),
                Obx(() => InkWell(
                      onTap: () {
                        print('同意协议');
                        state.userAgreement.value = !state.userAgreement.value;
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 60.sp,
                          height: 60.sp,
                          child: Container(
                            alignment: Alignment.center,
                            width: 30.sp,
                            height: 30.sp,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: state.userAgreement.value
                                      ? Colors.blue
                                      : Color(0xFFBDC2CE),
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: state.userAgreement.value
                                ? Icon(
                                    Icons.done,
                                    size: 20.sp,
                                    color: Colors.blue,
                                  )
                                : Container(),
                          )),
                    )),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "同意",
                      style: TextStyle(color: Color(0xFF999999), fontSize: 10)),
                  TextSpan(
                    text: "《咨询预约协议》",
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                    recognizer: _registProtocolRecognizer
                      ..onTap = () {
                        //打开隐私协议
                        String url =
                            "https://706xinli.com/agreement/consultAgreement.html";
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return H5WebViewPage(
                            title: "咨询预约协议",
                            url: url,
                          );
                        }));
                        DataStatistics.instance
                            .event("open_consulting_agreement", {"value": ""});
                      },
                  ),
                  TextSpan(
                      text: "与",
                      style: TextStyle(color: Color(0xFF999999), fontSize: 10)),
                  TextSpan(
                    text: "《知情同意书》",
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                    recognizer: _privacyProtocolRecognizer
                      ..onTap = () {
                        //打开隐私协议
                        String url =
                            "https://706xinli.com/agreement/consentForm.html";
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return H5WebViewPage(
                            title: "知情同意书",
                            url: url,
                          );
                        }));
                        DataStatistics.instance
                            .event("open_informed_consent_form", {"value": ""});
                      },
                  ),
                ]))
              ],
            ), //用户协议
            Divider(
              height: 1.sp,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 30.sp, 30.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "总计  ",
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF666666))),
                      TextSpan(
                          text: "¥",
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF666666))),
                      TextSpan(
                          text:
                              "${state.combo.isEmpty ? "" : state.combo['originalPrice']}",
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.bold)),
                    ], style: TextStyle(fontSize: 30.sp))),
                    TextButton(
                      onPressed: () {
                        DataStatistics.instance.event("pay_for", {"value": ""});
                        logic.pay();
                      },
                      child: Text("去支付", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          //设置按下时的背景颜色
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue[200];
                          }
                          //默认不使用背景颜色
                          return Colors.orangeAccent[700];
                        }),
                        //设置阴影  不适用于这里的TextButton
                        //设置按钮内边距
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(14.sp)),
                        //设置按钮的大小
                        minimumSize:
                            MaterialStateProperty.all(Size(232.sp, 68.sp)),
                        //外边框装饰 会覆盖 side 配置的样式
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                    ),
                  ]),
            )
          ],
        ));
  }

  ///咨询方式下拉选择菜单
  PopupMenuButton _showPopupMenuButton(Widget widget) {
    return PopupMenuButton(
      child: widget,
      itemBuilder: (BuildContext context) => _combosView(),
      onSelected: (object) {
        DataStatistics.instance
            .event("counseling_combo", {"comboName": "${object['comboName']}"});
        setState(() {
          state.combo.value = object;
        });
      },
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
    );
  }

  List<PopupMenuItem> _combosView() {
    List<PopupMenuItem> returnDate = [];
    List combos = state.counselorInfo['combos'].toList();
    if (combos.length != 0) {
      combos.forEach((element) {
        returnDate.add(PopupMenuItem(
          child: ListTile(
            title: Text(
              element['comboName'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          value: element,
        ));
      });
    }
    return returnDate;
  }
}
