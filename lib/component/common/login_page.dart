import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/common/input_widget.dart';
import 'package:standard_app/component/common/wechat_utils.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data_statistics.dart';

class LoginPage extends StatelessWidget {
  final LoginController login = Get.put(LoginController());
  final LoginState state = Get.find<LoginController>().state;

  Widget build(BuildContext context) {
    return Container(
        height: Get.height,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 260.sp,
          ),
          Image.asset(ImageUtils.getImgPath("logox3")),
          SizedBox(height: 10),
          Text("心     理     咨     询",
              style: TextStyle(fontSize: 11, color: Color(0xFF0B65DF))),
          SizedBox(height: 80),
          Obx(() => InputWidget(
                title: "+86    ",
                hintText: "请输入手机号",
                controller: login.phoneController,
                buttonName: state.verificationTitle.value,
                buttonAction: () {
                  login.sendVerificationCode();
                },
              )),
          SizedBox(
            height: 20.sp,
          ),
          InputWidget(
            title: "验证码",
            hintText: "请输入6位验证码",
            controller: login.codeController,
          ),
          SizedBox(
            height: 40.sp,
          ),
          userAgreementWidget(),
          SizedBox(height: 80.sp),
          loginBtnWidget(),
          SizedBox(height: 160.sp),
          Container(
            margin: EdgeInsets.only(left: 60.sp, right: 60.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140.sp,
                  height: 0.5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFFE3EBF0)),
                  ),
                ),
                SizedBox(
                  width: 20.sp,
                ),
                Text(
                  "其他方式登录",
                  style: TextStyle(fontSize: 13, color: Color(0xFF6E788A)),
                ),
                SizedBox(
                  width: 20.sp,
                ),
                SizedBox(
                  width: 140.sp,
                  height: 0.5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFFE3EBF0)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60.sp,
          ),
          Container(
              margin: EdgeInsets.only(left: 100.sp, right: 100.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Offstage(
                        offstage: true,
                        child: InkWell(
                          onTap: () {
                            Toasts.show("该功能暂未开放，敬请期待");
                          },
                          child: Image.asset(
                            ImageUtils.getImgPath("qq3x"),
                            width: 70.r,
                            height: 70.r,
                          ),
                        )),
                    Obx(() => Offstage(
                        offstage: !state.installWx.value,
                        child: InkWell(
                            onTap: () {
                              if (state.isAgreement.value) {
                                showLoading2();
                                WeChatUtils().weChatLogin();
                              } else {
                                Toasts.show("请勾选用户协议");
                              }
                            },
                            child: Image.asset(
                              ImageUtils.getImgPath("wechar3x"),
                              width: 70.r,
                              height: 70.r,
                            )))),
                    Offstage(
                        offstage: true,
                        child: InkWell(
                            onTap: () {
                              Toasts.show("该功能暂未开放，敬请期待");
                            },
                            child: Image.asset(
                              ImageUtils.getImgPath("iphone3x"),
                              width: 70.r,
                              height: 70.r,
                            )))
                  ]))
        ])));
  }

  ///登录按钮
  TextButton loginBtnWidget() {
    return TextButton(
      onPressed: () {
        login.login();
      },
      child: Text(
        "登  录",
        style: TextStyle(fontSize: 30.sp, color: Colors.white),
      ),
      style: ButtonStyle(
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //默认不使用背景颜色
          return Color(0xFF5191E8);
        }),
        minimumSize: MaterialStateProperty.all(Size(630.sp, 80.sp)),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }

  ///用户协议
  Container userAgreementWidget() {
    return Container(
        margin: EdgeInsets.only(left: 50.sp, right: 50.sp),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Obx(() => InkWell(
                onTap: () {
                  print('同意协议');
                  state.isAgreement.value = !state.isAgreement.value;
                  print(state.isAgreement.value);
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
                            color: state.isAgreement.value
                                ? Colors.blue
                                : Color(0xFFBDC2CE),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: state.isAgreement.value
                          ? Icon(
                              Icons.done,
                              size: 20.sp,
                              color: Colors.blue,
                            )
                          : Container(),
                    )),
              )),
          Text("点击登录表示同意",
              style: TextStyle(fontSize: 12, color: Color(0xFF6E788A))),
          InkWell(
            onTap: () {
              DataStatistics.instance
                  .event("user_agreement_page", {"name": "1"});
              Get.toNamed(RouteConfig.userAgreementPage);
            },
            child: Text(
              "《用户服务协议》",
              style: TextStyle(fontSize: 12, color: Color(0xFF0B65DF)),
            ),
          ),
          Text("与", style: TextStyle(fontSize: 12, color: Color(0xFF6E788A))),
          InkWell(
            onTap: () {
              DataStatistics.instance
                  .event("user_agreement_page", {"name": "1"});
              Get.toNamed(RouteConfig.privacyPolicyPage);
            },
            child: Text("《隐私政策》",
                style: TextStyle(fontSize: 12, color: Color(0xFF0B65DF))),
          ),
        ]));
  }
}

class LoginController extends GetxController {
  final state = LoginState();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool isSendCode = false;

  ///定时器
  Timer _timer;
  int time = 60;

  LoginController() {
    //判断是否安装微信
    WeChatUtils().installFluwx().then((value) => state.installWx.value = value);
  }

  ///发送验证码请求
  void sendVerificationCode() {
    String phone = phoneController.text;
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(phone);
    if (!matched) {
      Toasts.show("请输入正确的手机号码");
      return;
    }
    if (!isSendCode) {
      _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
        time--;
        state.verificationTitle.value = "$time s";
        if (time == 0) {
          _timer.cancel();
          isSendCode = false;
          time = 60;
          state.verificationTitle.value = "重新获取验证码";
        }
      });
      ApiService().loginSendCode(phone);
    }
    isSendCode = true;
  }

  void phoneBinding() {
    print("object");
    String phone = phoneController.text;
    String code = codeController.text;
    if (verify(phone, code)) {
      Map map = {
        "username": phone,
        "password": code,
        "loginType": "platform",
        "type": 0,
        "userInfo": state.weCharUserInfo
      };
      ApiService().weCharBindingPhoneAndLogin(map);
      phoneController.text = "";
      codeController.text = "";
    }
  }

  ///登录
  void login() {
    String phone = phoneController.text;
    String code = codeController.text;
    if (verify(phone, code)) {
      Map map = {
        "username": phone,
        "password": code,
        "loginType": "platform",
        "type": 0
      };
      ApiService().login(map);
      codeController.text = "";
    }
  }

  ///数据验证
  bool verify(String phone, String code) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(phone);
    if (!matched) {
      Toasts.show("请输入正确的手机号码");
      return false;
    }
    if (code.length != 6) {
      Toasts.show("验证码长度不正确,请重新输入");
      return false;
    }
    if (!state.isAgreement.value) {
      Toasts.show("请您勾选用户协议");
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    print("离开登录页面");
    print('------------------------login--------------');
    _timer.cancel();
    phoneController.clear();
    codeController.clear();
    super.onClose();
  }
}

class LoginState {
  RxString phone;
  RxString code;
  RxBool isAgreement;
  RxString verificationTitle;

  RxBool installWx;

  ///微信授权登录用户信息
  RxMap weCharUserInfo;

  LoginState() {
    phone = "".obs;
    code = "".obs;
    isAgreement = false.obs;
    installWx = true.obs;
    verificationTitle = "获取验证码".obs;
    weCharUserInfo = {}.obs;
  }
}
