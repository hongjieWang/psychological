import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///订单缺省页面
class OrderDefaultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: StyleUtils.bgColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 164.sp,
          ),
          Image.asset(ImageUtils.getImgPath("not_order3x")),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            "暂无订单",
            style: TextStyle(color: Color(0xFF969CA5), fontSize: 11),
          ),
          SizedBox(
            height: 60.sp,
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(RouteConfig.main);
            },
            child: Text(
              "去看看",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            style: ButtonStyle(
              //背景颜色
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[200];
                }
                //默认不使用背景颜色
                return Color(0xFF80ADEA);
              }),
              //设置按钮内边距
              padding: MaterialStateProperty.all(EdgeInsets.all(7)),
              //设置按钮的大小
              minimumSize: MaterialStateProperty.all(Size(300.sp, 68.sp)),

              //外边框装饰 会覆盖 side 配置的样式
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
          )
        ],
      ),
    );
  }
}
