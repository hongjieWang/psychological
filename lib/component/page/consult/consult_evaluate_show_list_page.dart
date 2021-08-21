import 'package:flutter/material.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///用户评价列表
class EvaluateShowListPage extends StatefulWidget {
  EvaluateShowListPage({Key key}) : super(key: key);

  @override
  _EvaluateShowListPageState createState() => _EvaluateShowListPageState();
}

class _EvaluateShowListPageState extends State<EvaluateShowListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("用户评价"),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(32.sp, 26.sp, 32.sp, 0.sp),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_labelObj()]),
      ),
    );
  }

  ///标签部分
  Column _labelObj() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "总体印象",
        style: TextStyle(
            fontSize: 32.sp,
            color: StyleUtils.fontColor_3,
            fontWeight: FontWeight.w500),
      ),
      Wrap(
        spacing: 8.0.sp, // 主轴(水平)方向间距
        runSpacing: -26.sp, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //沿主轴方向居中
        children: <Widget>[
          label("全部 6221"),
          label("态度很好 986"),
          label("很专业 789"),
          label("和蔼可亲 789"),
          label("全部 6221"),
          label("态度很好 986"),
          label("很专业 789"),
          label("和蔼可亲 789"),
        ],
      )
    ]);
  }

  ///单个标签样式
  TextButton label(String value) {
    return TextButton(
      onPressed: () {},
      child: Text(
        value,
        style: TextStyle(fontSize: 20.sp, color: StyleUtils.fontColor_6),
      ),
      style: ButtonStyle(
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //设置按下时的背景颜色
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          //默认不使用背景颜色
          return Color(0xFFE3E3E3);
        }),
        //设置按钮内边距
        padding: MaterialStateProperty.all(EdgeInsets.all(4.sp)),
        //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(162.sp, 40.sp)),

        //外边框装饰 会覆盖 side 配置的样式
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}
