import 'package:flutter/material.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataDefaultPage extends StatelessWidget {
  const NoDataDefaultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StyleUtils.bgColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 200.sp,
          ),
          Image.asset(ImageUtils.getImgPath("no_data2x")),
          SizedBox(
            height: 40.sp,
          ),
          Text(
            "暂无数据",
            style: TextStyle(color: Color(0xFF969CA5), fontSize: 22.sp),
          )
        ],
      ),
    );
  }
}
