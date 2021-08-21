import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//显示中间弹窗
void popDialog(BuildContext context, Widget widget) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return widget;
      });
}

showLoading2() {
  showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        return Center(
            child: Container(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            backgroundColor: Colors.blue,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ));
      });
}

Future<bool> showLoading({text: "正在加载，请稍后..."}) {
  return showCustomDialog<bool>(
    context: Get.context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Text(text),
          ],
        ),
      );
    },
  );
}

Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87, // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
