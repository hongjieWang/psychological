import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 头像组建
class Avatar extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Function onTapFun;
  final padding;
  final item;
  const Avatar({
    Key key,
    this.url,
    this.width,
    this.height,
    this.onTapFun,
    this.item,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: padding == null ? EdgeInsets.all(8.sp) : padding,
        child: InkWell(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                url,
                width: width.r,
                height: height.r,
              )),
          onTap: () {
            onTapFun(item);
          },
        ),
      ),
    );
  }
}
