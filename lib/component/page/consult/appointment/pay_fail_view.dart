import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';

///支付失败页面
class PayFailPage extends StatefulWidget {
  const PayFailPage({Key key}) : super(key: key);

  @override
  _PayFailPageState createState() => _PayFailPageState();
}

class _PayFailPageState extends State<PayFailPage> {
  Map content = Get.arguments;

  @override
  void initState() {
    super.initState();
  }

  void pay() {
    Get.toNamed(RouteConfig.appointmentPayPage, arguments: {
      "order": {},
      "combo": content['combo'],
      "item": content['counselorInfo']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("支付失败"),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: StyleUtils.bgColor),
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Image.asset(
                ImageUtils.getImgPath("pay_fail"),
                width: 103,
                height: 103,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.offAllNamed(RouteConfig.main);
                      },
                      child: Text(
                        "返回首页",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      style: ButtonStyle(
                        //背景颜色
                        backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                          //默认不使用背景颜色
                          return Color(0xFFF2C13B);
                        }),
                        //设置按钮内边距
                        padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                        //设置按钮的大小
                        minimumSize: MaterialStateProperty.all(Size(115, 34)),
                        //外边框装饰 会覆盖 side 配置的样式
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      )),
                  TextButton(
                      onPressed: () {
                        pay();
                      },
                      child: Text("重新支付",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      style: ButtonStyle(
                        //背景颜色
                        backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                          //默认不使用背景颜色
                          return Colors.blue;
                        }),
                        //设置按钮内边距
                        padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                        //设置按钮的大小
                        minimumSize: MaterialStateProperty.all(Size(115, 34)),
                        //外边框装饰 会覆盖 side 配置的样式
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      )),
                ],
              )
            ],
          )),
    );
  }
}
