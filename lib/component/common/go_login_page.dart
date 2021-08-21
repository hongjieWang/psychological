import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';

///去登录页面
class GoLoginPage extends StatelessWidget {
  bool showAppBar = true;

  GoLoginPage(bool showAppBar, {Key key}) {
    this.showAppBar = showAppBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? StyleUtils.buildAppBar("去登录") : null,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(ImageUtils.getImgPath("go_login")),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Get.offNamed(RouteConfig.loginPage);
                });
              },
              child: Text(
                "去登录",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                //背景颜色
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //默认不使用背景颜色
                  return Color(0xFF80ADEA);
                }),
                //设置按钮内边距
                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                //设置按钮的大小
                minimumSize: MaterialStateProperty.all(Size(151, 34)),
                shape: MaterialStateProperty.all(StadiumBorder()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
