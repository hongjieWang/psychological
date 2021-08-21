import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/page/index_page.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaySuccessPage extends StatefulWidget {
  @override
  _PaySuccessPageState createState() => _PaySuccessPageState();
}

class _PaySuccessPageState extends State<PaySuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: StyleUtils.buildAppBar("支付成功"),
        body: _body(),
      ),
    );
  }

  ///支付成功主体页面
  Widget _body() {
    return Container(
        height: 888888.sp,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    ImageUtils.getImgPath("pay_success"),
                    width: 300.sp,
                    height: 300.sp,
                    fit: BoxFit.cover,
                  ),
                  Text("恭喜您，支付成功!",
                      style: TextStyle(
                          fontSize: 38.sp, fontWeight: FontWeight.bold))
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: 60.sp, right: 60.sp),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            DataStatistics.instance
                                .event("go_back_home", {"key": ""});
                            Get.offAllNamed(RouteConfig.main);
                          },
                          child: Text(
                            "返回首页",
                            style: TextStyle(color: Colors.grey),
                          ),
                          style: _btnStyle(Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            DataStatistics.instance
                                .event("go_appointment", {"key": ""});
                            Get.to(IndexPage(currentIndex: 1));
                          },
                          child: Text(
                            "立即预约",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: _btnStyle(Colors.orangeAccent),
                        )
                      ])),
            ]));
  }

  ButtonStyle _btnStyle(Color color) {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(250.sp, 80.sp)),
      //设置边框
      side: MaterialStateProperty.all(
          BorderSide(color: Colors.orangeAccent, width: 1)),
      //外边框装饰 会覆盖 side 配置的样式
      shape: MaterialStateProperty.all(StadiumBorder()),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //设置按下时的背景颜色
        if (states.contains(MaterialState.pressed)) {
          return Colors.blue[200];
        }
        //默认不使用背景颜色
        return color;
      }),
    );
  }
}
