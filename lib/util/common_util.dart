import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui show window;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonUtil {
  /// 格式化小数
  /// digit:保留的位数ø
  static String formatNum(double numDouble, int digit) {
    var num = (numDouble * 100).toStringAsFixed(digit);
    return num.substring(0, num.lastIndexOf('.') + digit + 1);
  }

  static int getRandom(int maxSize) {
    return Random().nextInt(maxSize);
  }

  /**
   * 将毫秒转化为 "00:45"
   */
  static String getTimeStamp(int milliseconds) {
    if (milliseconds != null) {
      int seconds = (milliseconds / 1000).truncate();
      int minutes = (seconds / 60).truncate();

      String minutesStr = (minutes % 60).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');
      return "$minutesStr:$secondsStr";
    }
    return "";
  }

  static setBarStatus(bool isDarkIcon,
      {Color color: Colors.transparent}) async {
    if (Platform.isAndroid) {
      if (isDarkIcon) {
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
            statusBarColor: color, statusBarIconBrightness: Brightness.dark);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      } else {
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
            statusBarColor: color, statusBarIconBrightness: Brightness.light);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    }
  }

  /// 获取时间戳距离现在的时间
  static getTime(int time, int curTime) {
    int differTime = curTime - time;
    if (differTime <= 60 * 60 * 1000) {
      return "刚刚";
    } else if (differTime > 60 * 60 * 1000 &&
        differTime <= 24 * 60 * 60 * 1000) {
      return '${(differTime / (60 * 60 * 1000)).round()} 小时前';
    } else {
      return '${(differTime / (24 * 60 * 60 * 1000)).round()} 天前';
    }
  }

  /// 状态栏高度
  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  /// 底部状态栏高度
  ///
  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }
}
