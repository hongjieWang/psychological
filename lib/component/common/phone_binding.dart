import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/common/input_widget.dart';
import 'package:standard_app/component/common/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///手机号绑定
class PhoneBindingPage extends StatelessWidget {
  final LoginController login = Get.put(LoginController());
  final LoginState state = Get.find<LoginController>().state;
  @override
  Widget build(BuildContext context) {
    state.weCharUserInfo.value = Get.arguments != null ? Get.arguments : {};
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black), //自定义图标
              onPressed: () {
                // 打开抽屉菜单
                Get.back();
              },
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: Get.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Text("绑定手机号",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Text("首次登录产品，请绑定手机号",
                      style: TextStyle(fontSize: 12, color: Color(0xFF666666))),
                ),
                SizedBox(
                  height: 40,
                ),
                Obx(() => InputWidget(
                      title: "手机号",
                      hintText: "请输入手机号",
                      controller: login.phoneController,
                      buttonName: state.verificationTitle.value,
                      buttonAction: () {
                        login.sendVerificationCode();
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                InputWidget(
                    title: "验证码",
                    hintText: "请输入六位验证码",
                    controller: login.codeController),
                SizedBox(
                  height: 60,
                ),

                ///登录按钮
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: TextButton(
                      onPressed: () {
                        login.phoneBinding();
                      },
                      child: Text(
                        "下一步",
                        style: TextStyle(fontSize: 30.sp, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        //背景颜色
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          //默认不使用背景颜色
                          return Color(0xFF5191E8);
                        }),
                        minimumSize:
                            MaterialStateProperty.all(Size(630.sp, 80.sp)),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
