import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/component/common/alert_dialog.dart';
import 'package:standard_app/component/common/alert_dialog_706.dart';
import 'package:standard_app/util/dialog.dart';

class StyleUtils {
  ///背景颜色
  static Color bgColor = Color(0xFFF9FDFF);

  static Color fontColor_3 = Color(0xFF333333);
  static Color fontColor_6 = Color(0xFF666666);
  static Color fontColor_9 = Color(0xFF999999);

  /// app颜色
  static Color appBarColor = Color(0xFFF3F3F3);

  ///字体样式工具类
  static TextStyle textStyle(size, color, weight) {
    return TextStyle(fontSize: size, color: color, fontWeight: weight);
  }

  ///主题字体样式
  static TextStyle appBarTitleStyle() {
    return TextStyle(fontSize: 28.sp, color: Colors.black);
  }

  //头部样式
  static AppBar buildAppBar(title,
      {IconData icon,
      String diaTitle,
      String content,
      bool openAction = false,
      List<String> items,
      Function okFun,
      Function errorAction}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      centerTitle: true,
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Icon(icon != null ? icon : Icons.close,
              color: Colors.black), //自定义图标
          iconSize: 20,
          onPressed: () {
            // 打开抽屉菜单
            if (openAction) {
              popDialog(
                  context,
                  ShowAlertDialog706(
                    items: items != null ? items : ['取消', '确认'],
                    title: diaTitle != null ? diaTitle : "",
                    content: content != null ? content : '确认要离开嘛？',
                    onTap: (index) {
                      if (index == 1) {
                        if (okFun != null) {
                          okFun();
                        } else {
                          Navigator.pop(context);
                        }
                      } else {
                        if (errorAction != null) {
                          errorAction();
                        }
                      }
                    },
                  ));
            } else {
              Navigator.pop(context);
            }
          },
        );
      }),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
