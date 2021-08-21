import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';

///无网络缺省页面
class NoWifiPage extends StatelessWidget {
  const NoWifiPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 750.w,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: [
          SizedBox(
            height: 0.2.sh,
          ),
          Image.asset(ImageUtils.getImgPath("no_wifi")),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "啊哦，没有网络",
            style: TextStyle(color: Color(0xFF969CA5), fontSize: 22.sp),
          ),
          SizedBox(height: 0.1.sh),
          TextButton(
            onPressed: () {
              Get.offAndToNamed(RouteConfig.main);
            },
            child: Text("点击重试",
                style: TextStyle(color: Colors.white, fontSize: 28.sp)),
            style: ButtonStyle(
              //背景颜色
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[200];
                }
                //默认不使用背景颜色
                return Color(0xFF89C6EF);
              }),
              //设置按钮的大小
              minimumSize: MaterialStateProperty.all(Size(380.sp, 80.sp)),
              //外边框装饰 会覆盖 side 配置的样式
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
          )
        ]));
  }
}
