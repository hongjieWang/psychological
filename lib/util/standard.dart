import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIUtils {
  ///Iconlable显示组件
  static Widget lableIcon(
      String lable, IconData icon, Function onTop, BuildContext context) {
    return InkWell(
      onTap: () {
        context == null ? onTop() : onTop(context);
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              lable,
              style: TextStyle(color: Color(0xFF666666), fontSize: 13),
            ),
          ),
          Icon(
            icon,
            color: Color(0xFF666666),
            size: 20,
          )
        ],
      ),
    );
  }

  ///提交按钮
  static Widget submitBtn(String title, Function submitFun) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.sp, top: 50.sp),
      child: TextButton(
        onPressed: () {
          submitFun();
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue[200];
            }
            //默认不使用背景颜色
            return Colors.blue;
          }),
          minimumSize: MaterialStateProperty.all(Size(686.sp, 68.sp)),
          //设置边框

          padding: MaterialStateProperty.all(EdgeInsets.all(14.sp)),
          shape: MaterialStateProperty.all(StadiumBorder()),
        ),
      ),
    );
  }

  // 弹出对话框
  static Future<bool> showGiveUpDialog(
      BuildContext context, String title, String value, Function okFun) {
    return showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
              child: Text(
            value,
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.black54,
              height: 1.3,
            ),
          )),
          actions: <Widget>[
            TextButton(
              child: Text(
                "取消",
                style: TextStyle(fontSize: 30.sp),
              ),
              onPressed: () => Get.back(),
            ),
            TextButton(
              child: Text(
                "确认离开",
                style: TextStyle(fontSize: 30.sp),
              ),
              onPressed: () {
                print('00000');
                okFun();
              },
            )
          ],
        );
      },
    );
  }
}
